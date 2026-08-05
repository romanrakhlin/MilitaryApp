//
//  Place.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// A nearby discount or free location shown on the Discover map + list.
/// Coordinates are stored as plain doubles so the domain stays framework-free;
/// the presentation layer converts them to `CLLocationCoordinate2D`.
struct Place: Identifiable {
    let id: String
    let name: String
    let city: String?
    let category: String?
    let isFree: Bool
    let lat: Double
    let lng: Double
    let distanceMiles: Double?
    let isFavorite: Bool
}
