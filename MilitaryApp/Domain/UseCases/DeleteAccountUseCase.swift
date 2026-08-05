//
//  DeleteAccountUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Permanently deletes the signed-in account on the backend.
struct DeleteAccountUseCase {
    let repository: AuthRepository
    func callAsFunction() async throws {
        try await repository.deleteAccount()
    }
}
