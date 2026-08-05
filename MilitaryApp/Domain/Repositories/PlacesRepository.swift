//
//  PlacesRepository.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Nearby-places port.
protocol PlacesRepository {
    func places(lat: Double, lng: Double, radiusMiles: Int) async throws -> [Place]
}
