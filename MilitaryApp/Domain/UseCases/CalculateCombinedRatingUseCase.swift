//
//  CalculateCombinedRatingUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// "VA math": individual ratings don't add — each successive rating applies to
/// the remaining efficiency. The exact result is rounded to the nearest 10 to
/// get the payable rating, which maps to a monthly compensation estimate
/// (2025 rates, veteran with no dependents).
struct CalculateCombinedRatingUseCase {

    private static let monthlyCentsByRating: [Int: Int] = [
        10: 17_551, 20: 34_695, 30: 53_742, 40: 77_416, 50: 110_204,
        60: 139_593, 70: 175_919, 80: 204_489, 90: 229_796, 100: 383_130
    ]

    func callAsFunction(_ ratings: [Int]) -> CombinedRating {
        var remaining = 100.0
        for rating in ratings.sorted(by: >) {
            remaining *= (100.0 - Double(rating)) / 100.0
        }
        let exact = 100.0 - remaining
        let rounded = min(100, Int((exact / 10).rounded()) * 10)
        return CombinedRating(exactPercent: exact,
                              roundedPercent: rounded,
                              monthlyCents: Self.monthlyCentsByRating[rounded] ?? 0)
    }
}
