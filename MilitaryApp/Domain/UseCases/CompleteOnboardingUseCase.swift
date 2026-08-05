//
//  CompleteOnboardingUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Marks onboarding complete on the server.
struct CompleteOnboardingUseCase {
    let repository: ProfileRepository

    func callAsFunction() async throws {
        try await repository.completeOnboarding()
    }
}
