//
//  PlacesCache.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Disk cache for the Discover map: every place ever fetched this day plus
/// the circles (center + radius) already covered, so relaunches start warm
/// and panning inside known territory never re-hits the backend.
enum PlacesCache {

    /// An area the backend has already been queried for.
    struct CoveredCircle: Codable {
        let lat: Double
        let lng: Double
        let radiusMiles: Double
    }

    private struct Payload: Codable {
        let savedAt: Date
        let places: [Place]
        let circles: [CoveredCircle]
    }

    /// Cached data older than this is discarded (places change rarely).
    private static let maxAge: TimeInterval = 24 * 60 * 60

    private static var fileURL: URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("valor-places-cache.json")
    }

    static func load() -> (places: [Place], circles: [CoveredCircle])? {
        guard let data = try? Data(contentsOf: fileURL),
              let payload = try? JSONDecoder().decode(Payload.self, from: data),
              Date().timeIntervalSince(payload.savedAt) < maxAge
        else { return nil }
        return (payload.places, payload.circles)
    }

    static func save(places: [Place], circles: [CoveredCircle]) {
        let payload = Payload(savedAt: Date(), places: places, circles: circles)
        guard let data = try? JSONEncoder().encode(payload) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }
}
