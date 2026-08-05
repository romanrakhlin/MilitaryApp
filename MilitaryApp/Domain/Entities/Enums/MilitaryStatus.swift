//
//  MilitaryStatus.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// How the member describes themselves — drives which onboarding questions apply.
enum MilitaryStatus: String, CaseIterable, Codable, Identifiable {
    case activeDuty = "Active duty"
    case reservesGuard = "Reserves / Guard"
    case veteran = "Veteran"
    case retiree = "Retiree"
    case dependent = "Dependent / family"
    var id: String { rawValue }

    /// Server token expected by the API.
    var apiValue: String {
        switch self {
        case .activeDuty: return "active_duty"
        case .reservesGuard: return "reserves_guard"
        case .veteran: return "veteran"
        case .retiree: return "retiree"
        case .dependent: return "dependent"
        }
    }

    /// Reverse lookup from a server token.
    static func from(apiValue: String?) -> MilitaryStatus? {
        guard let apiValue else { return nil }
        return allCases.first { $0.apiValue == apiValue }
    }
}
