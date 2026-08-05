//
//  CombinedRating.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Result of combining individual disability ratings with "VA math".
struct CombinedRating: Equatable {
    /// The exact combined percentage before rounding, e.g. 76.3.
    let exactPercent: Double
    /// Rounded to the nearest 10 — the payable rating.
    let roundedPercent: Int
    /// Estimated monthly compensation (veteran alone) for the rounded rating.
    let monthlyCents: Int
}
