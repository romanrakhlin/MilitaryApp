//
//  ValorTab.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The three primary destinations of the main tab bar.
enum ValorTab: String, CaseIterable, Identifiable {
    case home = "Home"
    case explore = "Explore"
    case map = "Map"
    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .explore: return "square.grid.2x2.fill"
        case .map: return "map.fill"
        }
    }
}
