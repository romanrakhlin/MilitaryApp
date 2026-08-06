//
//  PrimaryGoal.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// What the member wants most — tailors the experience.
enum PrimaryGoal: String, CaseIterable, Codable, Identifiable {
    case maximize = "Maximize my benefits"
    case discounts = "Find discounts near me"
    case saveDaily = "Save money day to day"
    case retirement = "Understand my retirement"
    case other = "Other"
    var id: String { rawValue }

    var apiValue: String {
        switch self {
        case .maximize: return "maximize_benefits"
        case .discounts: return "find_discounts"
        case .saveDaily: return "save_daily"
        case .retirement: return "retirement"
        case .other: return "other"
        }
    }

    static func from(apiValue: String?) -> PrimaryGoal? {
        guard let apiValue else { return nil }
        return allCases.first { $0.apiValue == apiValue }
    }
}
