//
//  PayCategory.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Enlisted / Warrant / Officer, which determines the available pay grades.
enum PayCategory: String, CaseIterable, Codable, Identifiable {
    case enlisted = "Enlisted"
    case warrant = "Warrant"
    case officer = "Officer"
    var id: String { rawValue }

    var grades: [String] {
        switch self {
        case .enlisted: return (1...9).map { "E-\($0)" }
        case .warrant:  return (1...5).map { "W-\($0)" }
        case .officer:  return (1...10).map { "O-\($0)" }
        }
    }

    /// The server token (lowercased raw value).
    var apiValue: String { rawValue.lowercased() }

    /// Categories that actually exist for a branch. Space Force has no
    /// warrant officer corps, so it's hidden there.
    static func available(for branch: Branch?) -> [PayCategory] {
        branch == .spaceForce ? [.enlisted, .officer] : allCases
    }

    static func from(apiValue: String?) -> PayCategory? {
        guard let apiValue else { return nil }
        return allCases.first { $0.apiValue == apiValue }
    }
}
