//
//  SaveRatingUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Persists a rating calculation from the calculator tool.
struct SaveRatingUseCase {
    let repository: BenefitsRepository
    func callAsFunction(_ rating: SavedRating) {
        repository.save(rating: rating)
    }
}
