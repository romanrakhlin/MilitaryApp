//
//  ContentRepositoryLive.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Static editorial content (national chains + fallback articles) that isn't
/// yet served by the backend.
struct ContentRepositoryLive: ContentRepository {

    func chains() -> [NationalChain] {
        [
            .init(name: "American Legion", category: .food,
                  blurb: "Military discount on dining and meals — show military ID or CAC card at checkout.",
                  locations: 41),
            .init(name: "Arby's", category: .food,
                  blurb: "Military discount on dining and meals — show military ID or CAC card at checkout.",
                  locations: 15),
            .init(name: "Bonefish Grill", category: .food,
                  blurb: "Exclusive military discount on fresh seafood and steaks.",
                  locations: 157, discountBadge: "15% off"),
            .init(name: "Carrabba's Italian Grill", category: .food,
                  blurb: "Reduced rates on classic Italian dishes for service members.",
                  locations: 203),
            .init(name: "Chick-fil-A", category: .food,
                  blurb: "Military discount on dining and meals — show military ID or CAC card at checkout.",
                  locations: 98),
            .init(name: "Advance Auto Parts", category: .automotive,
                  blurb: "Everyday military savings on parts and accessories.",
                  locations: 210, discountBadge: "10% off"),
            .init(name: "Under Armour", category: .shopping,
                  blurb: "Verified military discount in-store and online.",
                  locations: 64, discountBadge: "20% off"),
            .init(name: "Hilton Hotels", category: .travel,
                  blurb: "Government and military rates at participating properties.",
                  locations: 340)
        ]
    }

    func articles() -> [Article] {
        [
            .init(emoji: "🤖", title: "Get a Free Year of ChatGPT Plus If You're Transitioning Out",
                  excerpt: "OpenAI is giving separating service members a year of Plus.",
                  tag: "CAREER", readMinutes: 3),
            .init(emoji: "📄", title: "American Monument For Service Members",
                  excerpt: "A new national memorial honoring those who served.",
                  tag: "MILITARY", readMinutes: 3),
            .init(emoji: "🚚", title: "Freedom Haulers: How Veterans Get a CDL Without the Cost",
                  excerpt: "The government just doubled down on funding CDL training for vets.",
                  tag: "CAREER", readMinutes: 5)
        ]
    }
}
