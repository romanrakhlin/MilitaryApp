//
//  DutyStatus.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Current duty status for Reserve / Guard members.
enum DutyStatus: String, CaseIterable, Codable, Identifiable {
    case drilling = "Drilling reservist"
    case agr = "Active Guard Reserve (AGR)"
    case mobilized = "Currently mobilized"
    case irr = "Inactive Ready Reserve (IRR)"
    var id: String { rawValue }

    var apiValue: String {
        switch self {
        case .drilling: return "drilling"
        case .agr: return "agr"
        case .mobilized: return "mobilized"
        case .irr: return "irr"
        }
    }

    static func from(apiValue: String?) -> DutyStatus? {
        guard let apiValue else { return nil }
        return allCases.first { $0.apiValue == apiValue }
    }
}
