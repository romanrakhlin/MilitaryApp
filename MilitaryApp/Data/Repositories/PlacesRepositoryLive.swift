//
//  PlacesRepositoryLive.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Live nearby-places access over the backend.
struct PlacesRepositoryLive: PlacesRepository {
    let api: APIClient

    func places(lat: Double, lng: Double, radiusMiles: Int) async throws -> [Place] {
        let res: PlacesResponse = try await api.get("/places?lat=\(lat)&lng=\(lng)&radius_miles=\(radiusMiles)")
        return PlaceMapper.places(from: res.data)
    }
}
