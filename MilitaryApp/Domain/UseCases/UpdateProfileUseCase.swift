//
//  UpdateProfileUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Persists the captured onboarding profile to the server.
struct UpdateProfileUseCase {
    let repository: ProfileRepository

    func callAsFunction(_ profile: UserProfile) async throws -> Account {
        try await repository.update(profile)
    }
}
