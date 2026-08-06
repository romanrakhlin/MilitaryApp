//
//  PlacesRepositoryLive.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Live nearby-places access over the backend.
///
/// `/places` is cursor-paginated (default page size 20), so a single request
/// silently drops everything past the first page. This walks `next_cursor`
/// with a large page size until the area is exhausted (safety-capped).
struct PlacesRepositoryLive: PlacesRepository {
    let api: APIClient

    private static let pageSize = 100
    private static let maxPages = 10

    func places(lat: Double, lng: Double, radiusMiles: Int) async throws -> [Place] {
        var all: [PlaceDTO] = []
        var cursor: String?

        for _ in 0..<Self.maxPages {
            var path = "/places?lat=\(lat)&lng=\(lng)&radius_miles=\(radiusMiles)&limit=\(Self.pageSize)"
            if let cursor { path += "&cursor=\(cursor)" }
            let res: PlacesResponse = try await api.get(path)
            all.append(contentsOf: res.data)
            guard let next = res.nextCursor, !next.isEmpty else { break }
            cursor = next
        }
        return PlaceMapper.places(from: all)
    }
}
