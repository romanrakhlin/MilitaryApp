//
//  DeleteRatingUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Removes a saved rating calculation.
struct DeleteRatingUseCase {
    let repository: BenefitsRepository
    func callAsFunction(_ id: UUID) {
        repository.deleteRating(id: id)
    }
}
