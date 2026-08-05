//
//  RestoreSessionUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// At launch, restores the account if a session token is already held.
/// Returns `nil` when there is nothing to restore.
struct RestoreSessionUseCase {
    let tokens: SessionTokens
    let profile: ProfileRepository

    func callAsFunction() async throws -> Account? {
        guard tokens.hasSession else { return nil }
        return try await profile.me()
    }
}
