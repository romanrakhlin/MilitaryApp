//
//  DiscountCategory.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// A category used to filter discounts and tag national chains.
enum DiscountCategory: String, CaseIterable, Codable, Identifiable {
    case food = "Food & Dining"
    case automotive = "Automotive"
    case shopping = "Shopping"
    case travel = "Travel & Lodging"
    case entertainment = "Entertainment"
    case health = "Health & Wellness"
    case outdoors = "Outdoors"
    var id: String { rawValue }
}
