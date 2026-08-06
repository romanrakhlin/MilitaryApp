//
//  DiscoverStore.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import Combine

/// Feature store for the Discover map: nearby places, the Map/List view mode,
/// search text, the Free/Discount mode + category filters, pin selection, and
/// the national-chains content.
///
/// Fetch strategy — designed to keep backend calls rare:
/// - Every fetched place is merged into an id-keyed cache that only grows,
///   so pins never disappear while panning and distances re-sort locally.
/// - Fetched areas are remembered as circles; a camera move inside covered
///   territory costs zero requests.
/// - Panning somewhere uncovered surfaces `needsAreaLoad` — the view shows a
///   "Search this area" button and the backend is only hit on demand.
/// - The cache persists to disk (24h TTL), so relaunches start warm.
@MainActor
final class DiscoverStore: ObservableObject {
    enum Mode { case free, discount }

    enum ViewMode: String, CaseIterable, Identifiable {
        case map = "Map"
        case list = "List"
        var id: String { rawValue }
    }

    private struct RegionRequest {
        let lat: Double
        let lng: Double
        let radiusMiles: Int
    }

    /// Cached places re-sorted by distance from the current map center.
    @Published private(set) var places: [Place] = []
    @Published private(set) var isLoading = false
    /// True when the visible region isn't covered by any past fetch.
    @Published private(set) var needsAreaLoad = false
    @Published var viewMode: ViewMode = .map
    @Published var query = ""
    /// nil = show every place; tapping a mode filters, tapping again clears.
    @Published var mode: Mode?
    @Published var category: DiscountCategory?
    @Published var selectedPlaceID: String?

    private let loadPlaces: LoadPlacesUseCase
    private let content: ContentRepository

    private var placesByID: [String: Place] = [:]
    private var covered: [PlacesCache.CoveredCircle] = []
    /// The region currently on screen (center + viewport radius).
    private var currentRegion: RegionRequest?
    private var fetchTask: Task<Void, Never>?
    private var didStartInitialLoad = false

    // DC seed area (backend seed covers DC + San Diego).
    private static let seed = RegionRequest(lat: 38.8977, lng: -77.0365, radiusMiles: 25)

    init(loadPlaces: LoadPlacesUseCase, content: ContentRepository) {
        self.loadPlaces = loadPlaces
        self.content = content
    }

    var chains: [NationalChain] { content.chains() }

    var filtered: [Place] {
        let search = query.trimmingCharacters(in: .whitespaces)
        return places.filter { place in
            switch mode {
            case .free: guard place.isFree else { return false }
            case .discount: guard !place.isFree else { return false }
            case nil: break
            }
            if let category, place.category?.caseInsensitiveCompare(category.rawValue) != .orderedSame {
                return false
            }
            if !search.isEmpty {
                let inName = place.name.localizedCaseInsensitiveContains(search)
                let inCity = place.city?.localizedCaseInsensitiveContains(search) ?? false
                guard inName || inCity else { return false }
            }
            return true
        }
    }

    var selectedPlace: Place? {
        selectedPlaceID.flatMap { id in filtered.first { $0.id == id } }
    }

    /// Number of active filters, shown as a badge on the filter button.
    var activeFilterCount: Int {
        (mode == nil ? 0 : 1) + (category == nil ? 0 : 1)
    }

    func clearFilters() {
        mode = nil
        category = nil
    }

    // MARK: Loading

    /// One-time startup: restore the disk cache, then fetch the visible (or
    /// seed) area only if it isn't already covered. Retries briefly because
    /// launch can race the session bootstrap (token not restored yet → 401).
    func loadIfNeeded() async {
        guard !didStartInitialLoad else { return }
        didStartInitialLoad = true

        if let cached = PlacesCache.load() {
            placesByID = Dictionary(cached.places.map { ($0.id, $0) },
                                    uniquingKeysWith: { _, new in new })
            covered = cached.circles
            rebuildPlaces()
        }

        let region = currentRegion ?? Self.seed
        guard !isCovered(region) else {
            refreshAreaState()
            return
        }

        isLoading = true
        defer { isLoading = false }
        for attempt in 0..<4 {
            if attempt > 0 { try? await Task.sleep(for: .seconds(1.5)) }
            let target = currentRegion ?? Self.seed
            if let result = try? await loadPlaces(lat: target.lat, lng: target.lng,
                                                  radiusMiles: target.radiusMiles),
               !result.isEmpty {
                merge(result, for: target)
                return
            }
        }
    }

    /// Called by the view whenever the map camera settles. Never hits the
    /// network — just re-sorts distances and updates the covered/uncovered
    /// state that drives the "Search this area" button.
    func updateRegion(lat: Double, lng: Double, radiusMiles: Int) {
        currentRegion = RegionRequest(lat: lat, lng: lng, radiusMiles: min(max(radiusMiles, 5), 300))
        rebuildPlaces()
        refreshAreaState()
    }

    /// "Search this area": fetch the visible region on demand.
    func searchCurrentArea() {
        fetch(currentRegion ?? Self.seed)
    }

    /// Reload button: refresh the visible area even if it's already covered.
    func reloadCurrentArea() {
        fetch(currentRegion ?? Self.seed)
    }

    private func fetch(_ request: RegionRequest) {
        guard !isLoading else { return }
        fetchTask?.cancel()
        fetchTask = Task {
            isLoading = true
            defer { isLoading = false }
            guard let result = try? await loadPlaces(lat: request.lat, lng: request.lng,
                                                     radiusMiles: request.radiusMiles),
                  !Task.isCancelled else { return }
            merge(result, for: request)
        }
    }

    /// Upsert fetched places into the cache, mark the area covered, persist,
    /// and refresh the published state.
    private func merge(_ fetched: [Place], for request: RegionRequest) {
        for place in fetched { placesByID[place.id] = place }
        covered.append(PlacesCache.CoveredCircle(lat: request.lat, lng: request.lng,
                                                 radiusMiles: Double(request.radiusMiles)))
        PlacesCache.save(places: Array(placesByID.values), circles: covered)
        rebuildPlaces()
        refreshAreaState()
    }

    /// Re-derive `places` from the cache: distances recomputed from the
    /// current map center so sorting stays honest as the user pans.
    private func rebuildPlaces() {
        let center = currentRegion ?? Self.seed
        places = placesByID.values
            .map { place in
                Place(id: place.id, name: place.name, city: place.city,
                      category: place.category, isFree: place.isFree,
                      lat: place.lat, lng: place.lng,
                      distanceMiles: Self.milesBetween(center.lat, center.lng, place.lat, place.lng),
                      isFavorite: place.isFavorite)
            }
            .sorted { ($0.distanceMiles ?? 0) < ($1.distanceMiles ?? 0) }
    }

    private func refreshAreaState() {
        let region = currentRegion ?? Self.seed
        needsAreaLoad = !isCovered(region)
    }

    /// A region counts as covered when most of the viewport sits inside a
    /// previously fetched circle (0.8 factor avoids flicker at the edges).
    private func isCovered(_ region: RegionRequest) -> Bool {
        covered.contains { circle in
            Self.milesBetween(circle.lat, circle.lng, region.lat, region.lng)
                + Double(region.radiusMiles) * 0.8 <= circle.radiusMiles
        }
    }

    private static func milesBetween(_ lat1: Double, _ lng1: Double,
                                     _ lat2: Double, _ lng2: Double) -> Double {
        let earthRadiusMiles = 3958.8
        let dLat = (lat2 - lat1) * .pi / 180
        let dLng = (lng2 - lng1) * .pi / 180
        let a = sin(dLat / 2) * sin(dLat / 2)
            + cos(lat1 * .pi / 180) * cos(lat2 * .pi / 180) * sin(dLng / 2) * sin(dLng / 2)
        return 2 * earthRadiusMiles * asin(min(1, sqrt(a)))
    }
}
