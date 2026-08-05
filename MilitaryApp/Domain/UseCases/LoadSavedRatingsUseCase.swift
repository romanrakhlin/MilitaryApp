//
//  LoadSavedRatingsUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Returns the disability calculations the user has saved, newest first.
struct LoadSavedRatingsUseCase {
    let repository: BenefitsRepository
    func callAsFunction() -> [SavedRating] {
        repository.loadSavedRatings().sorted { $0.savedAt > $1.savedAt }
    }
}
