//
//  InfoBenefitCategory.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Grouping for the informational perks section of the Home dashboard.
enum InfoBenefitCategory: String, CaseIterable, Identifiable {
    case airlines = "Airlines"
    case hotels = "Hotels"
    case shopping = "Shopping"
    var id: String { rawValue }
}
