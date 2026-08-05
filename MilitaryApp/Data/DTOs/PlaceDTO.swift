//
//  PlaceDTO.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The `/places` list envelope.
struct PlacesResponse: Decodable {
    let data: [PlaceDTO]
    let countInArea: Int?
    let nextCursor: String?
}

/// A single place record from the backend.
struct PlaceDTO: Decodable, Identifiable {
    struct Discount: Decodable {
        let summary: String?
        let valueType: String?
        let value: Double?
        let eligibility: [String]?
        let channel: String?
    }
    struct Verification: Decodable {
        let status: String?
        let confirmations: Int?
    }
    let id: String
    let type: String            // "discount" | "free"
    let name: String
    let category: String?
    let city: String?
    let address: String?
    let lat: Double
    let lng: Double
    let distanceMiles: Double?
    let discount: Discount?
    let verification: Verification?
    let isFavorite: Bool?

    var isFree: Bool { type == "free" }
}
