//
//  BenefitsRepository.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Port for the locally tracked benefits and saved rating calculations shown
/// on the Home dashboard.
protocol BenefitsRepository {
    func loadTrackedEntries() -> [TrackedBenefitEntry]
    func save(entry: TrackedBenefitEntry)
    func removeEntry(kind: TrackedBenefitKind)

    func loadSavedRatings() -> [SavedRating]
    func save(rating: SavedRating)
    func deleteRating(id: UUID)
}
