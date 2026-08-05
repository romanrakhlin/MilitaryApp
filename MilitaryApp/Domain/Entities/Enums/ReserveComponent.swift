//
//  ReserveComponent.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Reserve vs National Guard (asked only of Reserves / Guard members).
enum ReserveComponent: String, CaseIterable, Codable, Identifiable {
    case reserve = "Reserve"
    case nationalGuard = "National Guard"
    case both = "Both / transitioning"
    var id: String { rawValue }

    var apiValue: String {
        switch self {
        case .reserve: return "reserve"
        case .nationalGuard: return "national_guard"
        case .both: return "both"
        }
    }

    static func from(apiValue: String?) -> ReserveComponent? {
        guard let apiValue else { return nil }
        return allCases.first { $0.apiValue == apiValue }
    }
}
