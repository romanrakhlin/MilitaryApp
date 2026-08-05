//
//  LoadTrackedBenefitsUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Returns the benefits the user has configured on the dashboard.
struct LoadTrackedBenefitsUseCase {
    let repository: BenefitsRepository
    func callAsFunction() -> [TrackedBenefitEntry] {
        repository.loadTrackedEntries()
    }
}
