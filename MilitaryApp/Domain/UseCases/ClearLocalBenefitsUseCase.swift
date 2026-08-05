//
//  ClearLocalBenefitsUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Wipes all locally tracked benefits and saved ratings — used when the
/// account is deleted.
struct ClearLocalBenefitsUseCase {
    let repository: BenefitsRepository
    func callAsFunction() {
        repository.removeAllLocalData()
    }
}
