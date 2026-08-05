//
//  Branch.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Service branch.
enum Branch: String, CaseIterable, Codable, Identifiable {
    case army = "Army"
    case navy = "Navy"
    case airForce = "Air Force"
    case marineCorps = "Marine Corps"
    case spaceForce = "Space Force"
    case coastGuard = "Coast Guard"
    var id: String { rawValue }

    var apiValue: String {
        switch self {
        case .army: return "army"
        case .navy: return "navy"
        case .airForce: return "air_force"
        case .marineCorps: return "marine_corps"
        case .spaceForce: return "space_force"
        case .coastGuard: return "coast_guard"
        }
    }

    static func from(apiValue: String?) -> Branch? {
        guard let apiValue else { return nil }
        return allCases.first { $0.apiValue == apiValue }
    }
}
