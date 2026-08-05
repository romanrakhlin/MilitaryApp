//
//  LoadPlacesUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Loads nearby discount / free places around a coordinate.
struct LoadPlacesUseCase {
    let repository: PlacesRepository

    func callAsFunction(lat: Double, lng: Double, radiusMiles: Int = 25) async throws -> [Place] {
        try await repository.places(lat: lat, lng: lng, radiusMiles: radiusMiles)
    }
}
