//
//  SavedRating.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// A disability-rating calculation the user chose to keep from the calculator
/// tool.
struct SavedRating: Codable, Identifiable, Equatable {
    let id: UUID
    var name: String
    var ratings: [Int]
    var exactPercent: Double
    var roundedPercent: Int
    var monthlyCents: Int
    var savedAt: Date
}
