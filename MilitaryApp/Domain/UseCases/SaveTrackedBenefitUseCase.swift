//
//  SaveTrackedBenefitUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Creates or replaces the entry for a benefit kind.
struct SaveTrackedBenefitUseCase {
    let repository: BenefitsRepository
    func callAsFunction(_ entry: TrackedBenefitEntry) {
        repository.save(entry: entry)
    }
}
