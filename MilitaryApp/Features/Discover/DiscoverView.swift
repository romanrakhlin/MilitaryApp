//
//  DiscoverView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import MapKit

/// The map hub. A TikTok-style Map/List switcher and a search bar sit on top,
/// a floating filter button hangs on the left, and a native
/// `MapUserLocationButton` recenters on the user. Tapping a pin selects it and
/// slides a detail card up from the bottom; List mode swaps the map for a
/// scrollable list of the same filtered results.
struct DiscoverView: View {
    @StateObject private var store: DiscoverStore
    @Namespace private var mapScope

    // DC seed area by default (backend seed covers DC + San Diego);
    // `-startSanDiego` launch argument boots over the west-coast seed instead.
    private static var initialCenter: CLLocationCoordinate2D {
        ProcessInfo.processInfo.arguments.contains("-startSanDiego")
            ? CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611)
            : CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365)
    }

    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(
        center: DiscoverView.initialCenter,
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)))
    @State private var showFilters = false
    @State private var showSearch = false
    @State private var showLocationDeniedAlert = false

    init(container: AppContainer) {
        _store = StateObject(wrappedValue: container.makeDiscoverStore())
    }

    var body: some View {
        ZStack {
            switch store.viewMode {
            case .map:
                mapLayer.transition(.opacity)
            case .list:
                PlacesListView(places: store.filtered, isLoading: store.isLoading, onSelect: focusFromList)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.22), value: store.viewMode)
        .safeAreaInset(edge: .top, spacing: 0) { topOverlay }
        .mapScope(mapScope)
        .sheet(isPresented: $showFilters) {
            FilterSheet(store: store)
        }
        .fullScreenCover(isPresented: $showSearch) {
            PlaceSearchScreen(store: store)
        }
        .alert("Turn On Location", isPresented: $showLocationDeniedAlert) {
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            Button("Not Now", role: .cancel) {}
        } message: {
            Text("Location access is off, so the map can't show military discounts and free recreation sites near you. You can turn it on in Settings.")
        }
        .task { await store.loadIfNeeded() }
        .onAppear {
            LocationManager.shared.requestWhenInUseIfNeeded()
            if LocationManager.shared.shouldShowDeniedAlert() {
                showLocationDeniedAlert = true
            }
            // `-openList` / `-openSearch` / `-openFilters` launch arguments boot
            // those states directly for automated screenshots.
            let args = ProcessInfo.processInfo.arguments
            if args.contains("-openList") { store.viewMode = .list }
            if args.contains("-openSearch") { showSearch = true }
            if args.contains("-openFilters") { showFilters = true }
        }
        .onChange(of: store.selectedPlaceID) { _, newValue in
            guard let place = store.filtered.first(where: { $0.id == newValue }) else { return }
            withAnimation(.easeOut(duration: 0.4)) {
                position = .region(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
            }
        }
    }

    // MARK: Map

    private var mapLayer: some View {
        Map(position: $position, selection: $store.selectedPlaceID, scope: mapScope) {
            UserAnnotation()
            ForEach(store.filtered) { place in
                Annotation(place.name, coordinate: CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)) {
                    PlaceAnnotationView(isFree: place.isFree, isSelected: store.selectedPlaceID == place.id)
                }
                .tag(place.id)
            }
        }
        .mapStyle(.standard(elevation: .realistic, pointsOfInterest: .excludingAll))
        .ignoresSafeArea(.container, edges: .top)
        .overlay(alignment: .bottom) { bottomOverlay }
        .onMapCameraChange(frequency: .onEnd) { context in
            let region = context.region
            let latMiles = region.span.latitudeDelta * 69.0
            let lngMiles = region.span.longitudeDelta * 69.0 * cos(region.center.latitude * .pi / 180)
            // Fetch a bit past the viewport so pins exist just off-screen.
            let radiusMiles = Int((max(latMiles, lngMiles) / 2) * 1.3)
            store.updateRegion(lat: region.center.latitude,
                               lng: region.center.longitude,
                               radiusMiles: radiusMiles)
        }
    }

    /// Locate button pinned bottom-trailing, with the selected-place card
    /// sliding in underneath it.
    private var bottomOverlay: some View {
        VStack(spacing: 12) {
            HStack {
                Spacer()
                VStack(spacing: 10) {
                    Button {
                        Haptics.impact()
                        store.reloadCurrentArea()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(store.isLoading ? Valor.textTertiary : Valor.blue)
                            .frame(width: 44, height: 44)
                            .background(Circle().fill(.regularMaterial))
                            .overlay(Circle().strokeBorder(Valor.cardStroke))
                            .shadow(color: .black.opacity(0.15), radius: 6, y: 2)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .disabled(store.isLoading)
                    .accessibilityLabel("Reload this area")

                    MapUserLocationButton(scope: mapScope)
                        .buttonBorderShape(.circle)
                        .tint(Valor.blue)
                        .shadow(color: .black.opacity(0.15), radius: 6, y: 2)
                }
            }
            if let place = store.selectedPlace {
                PlaceDetailCard(place: place) { store.selectedPlaceID = nil }
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 12)
        .animation(.spring(duration: 0.35), value: store.selectedPlaceID)
    }

    // MARK: Top controls

    /// One header row, TikTok-style: Filters pill left, Search pill right,
    /// the Map/List tabs centered between them.
    private var topOverlay: some View {
        VStack(spacing: 10) {
            ZStack {
                DiscoverTopTabs(selection: $store.viewMode)
                HStack {
                    DiscoverHeaderButton(icon: "line.3.horizontal.decrease", title: "Filters",
                                         badgeCount: store.activeFilterCount) {
                        Haptics.impact()
                        showFilters = true
                    }
                    Spacer()
                    DiscoverHeaderButton(icon: "magnifyingglass", title: "Search") {
                        Haptics.impact()
                        showSearch = true
                    }
                }
            }

            if store.viewMode == .map {
                if store.isLoading {
                    HStack(spacing: 8) {
                        ProgressView().controlSize(.small)
                        Text("Loading places")
                            .font(.valorFont(13, weight: .semibold))
                            .foregroundStyle(Valor.textSecondary)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 9)
                    .background(Capsule().fill(.regularMaterial))
                    .overlay(Capsule().strokeBorder(Valor.cardStroke))
                    .transition(.opacity)
                } else if store.needsAreaLoad {
                    Button {
                        Haptics.impact()
                        store.searchCurrentArea()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 12, weight: .bold))
                            Text("Search this area")
                                .font(.valorFont(14, weight: .semibold))
                        }
                        .foregroundStyle(Valor.blue)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 9)
                        .background(Capsule().fill(.regularMaterial))
                        .overlay(Capsule().strokeBorder(Valor.cardStroke))
                        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .transition(.opacity)
                } else if store.filtered.isEmpty && !store.places.isEmpty {
                    DiscoverEmptyHint(hasFilters: store.activeFilterCount > 0 || !store.query.isEmpty) {
                        store.clearFilters()
                        store.query = ""
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 4)
        .padding(.bottom, 8)
        .animation(.easeInOut(duration: 0.2), value: store.isLoading)
        .animation(.easeInOut(duration: 0.2), value: store.needsAreaLoad)
    }

    /// A list row was tapped: select the place and jump back to the map.
    private func focusFromList(_ place: Place) {
        Haptics.selection()
        store.selectedPlaceID = place.id
        withAnimation(.snappy) { store.viewMode = .map }
    }
}
