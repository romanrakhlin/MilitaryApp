//
//  TrackedBenefitKind.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The benefits a user can set up on the Home dashboard. Each configured kind
/// contributes its annual value to the tracked total.
enum TrackedBenefitKind: String, Codable, CaseIterable {
    case creditCards
    case vaDisability
    case tspMatch
    case commissary
}
