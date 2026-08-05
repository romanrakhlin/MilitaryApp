//
//  RegisterUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Creates a new account.
struct RegisterUseCase {
    let repository: AuthRepository

    func callAsFunction(email: String, password: String, name: String?) async throws -> Account {
        try await repository.register(email: email, password: password, name: name)
    }
}
