//
//  LoadProfileUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Fetches the current authenticated account / profile.
struct LoadProfileUseCase {
    let repository: ProfileRepository

    func callAsFunction() async throws -> Account {
        try await repository.me()
    }
}
