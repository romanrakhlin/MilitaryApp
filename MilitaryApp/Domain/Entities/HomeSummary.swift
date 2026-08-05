//
//  HomeSummary.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The Home dashboard payload, shaped for the view: greeting, tracked value,
/// the four tiles, the Recon shortcut, a map preview, and latest articles.
struct HomeSummary {
    struct Greeting { let partOfDay: String; let name: String? }
    struct Tracked { let totalCents: Int; let acrossCount: Int }
    struct Tile { let valueDisplay: String; let subtitle: String?; let cta: String? }
    struct Tiles { let cards: Tile; let income: Tile; let tsp: Tile; let perks: Tile }
    struct Recon { let title: String; let subtitle: String; let deeplink: String }

    struct MapMarker: Identifiable {
        let lat: Double
        let lng: Double
        let isFree: Bool
        var id: String { "\(lat),\(lng)" }
    }
    struct MapPreview { let centerLat: Double; let centerLng: Double; let markers: [MapMarker] }

    struct HomeArticle: Identifiable {
        let id: String
        let emoji: String
        let title: String
        let excerpt: String
        let tag: String
        let readMinutes: Int
    }

    let greeting: Greeting
    let benefitsTracked: Tracked
    let tiles: Tiles
    let recon: Recon
    let mapPreview: MapPreview?
    let latestArticles: [HomeArticle]?
}
