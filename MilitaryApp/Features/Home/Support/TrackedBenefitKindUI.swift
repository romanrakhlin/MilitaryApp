//
//  TrackedBenefitKindUI.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Presentation attributes for each trackable benefit — kept out of Domain so
/// the entity stays framework-free.
extension TrackedBenefitKind: Identifiable {
    var id: String { rawValue }

    var title: String {
        switch self {
        case .creditCards: return "Credit Cards"
        case .vaDisability: return "VA Disability"
        case .tspMatch: return "TSP Match"
        case .commissary: return "Commissary"
        }
    }

    var subtitle: String {
        switch self {
        case .creditCards: return "Annual fees waived on premium cards"
        case .vaDisability: return "Monthly tax-free compensation"
        case .tspMatch: return "Free agency match, up to 5%"
        case .commissary: return "Save about 25% on groceries"
        }
    }

    var icon: String {
        switch self {
        case .creditCards: return "creditcard.fill"
        case .vaDisability: return "heart.text.square.fill"
        case .tspMatch: return "chart.line.uptrend.xyaxis"
        case .commissary: return "cart.fill"
        }
    }

    var tint: Color {
        switch self {
        case .creditCards: return Valor.blue
        case .vaDisability: return Valor.red
        case .tspMatch: return Valor.green
        case .commissary: return Color.orange
        }
    }
}
