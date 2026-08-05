//
//  RemoveTrackedBenefitUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Clears a configured benefit so it no longer counts toward the total.
struct RemoveTrackedBenefitUseCase {
    let repository: BenefitsRepository
    func callAsFunction(_ kind: TrackedBenefitKind) {
        repository.removeEntry(kind: kind)
    }
}
