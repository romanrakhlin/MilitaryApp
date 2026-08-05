//
//  LoginUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Logs in an existing account.
struct LoginUseCase {
    let repository: AuthRepository

    func callAsFunction(email: String, password: String) async throws -> Account {
        try await repository.login(email: email, password: password)
    }
}
