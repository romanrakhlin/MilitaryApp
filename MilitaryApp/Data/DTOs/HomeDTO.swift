//
//  HomeDTO.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The `/home` dashboard payload.
struct HomeDTO: Decodable {
    struct Greeting: Decodable { let partOfDay: String; let name: String? }
    struct Tracked: Decodable { let totalCents: Int; let acrossCount: Int }
    struct Tile: Decodable {
        let state: String?
        let valueCents: Int?
        let valueDisplay: String
        let subtitle: String?
        let cta: String?
    }
    struct Tiles: Decodable { let cards: Tile; let income: Tile; let tsp: Tile; let perks: Tile }
    struct Recon: Decodable { let title: String; let subtitle: String; let deeplink: String }
    struct Coord: Decodable { let lat: Double; let lng: Double }
    struct MapMarker: Decodable {
        let lat: Double; let lng: Double; let type: String
        var isFree: Bool { type == "free" }
    }
    struct MapPreview: Decodable { let center: Coord; let markers: [MapMarker] }
    struct HomeArticle: Decodable {
        let id: String; let emoji: String; let title: String
        let excerpt: String; let tag: String; let readMinutes: Int
    }

    let greeting: Greeting
    let benefitsTracked: Tracked
    let tiles: Tiles
    let recon: Recon
    let mapPreview: MapPreview?
    let latestArticles: [HomeArticle]?
}
