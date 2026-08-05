//
//  InfoBenefitCategoryUI.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Presentation attributes for the perk categories — kept out of Domain so
/// the entity stays framework-free.
extension InfoBenefitCategory {
    var icon: String {
        switch self {
        case .airlines: return "airplane"
        case .hotels: return "bed.double.fill"
        case .shopping: return "bag.fill"
        case .state: return "building.columns.fill"
        }
    }

    var tint: Color {
        switch self {
        case .airlines: return Valor.blue
        case .hotels: return Color.purple
        case .shopping: return Color.orange
        case .state: return Valor.green
        }
    }

    /// Unit for the count shown on the category button ("12 brands").
    var unitLabel: String {
        switch self {
        case .state: return "states"
        default: return "brands"
        }
    }
}
