//
//  AuthRepository.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Authentication port. Implementations persist the resulting session tokens
/// as a side effect and return the authenticated `Account`.
protocol AuthRepository {
    func login(email: String, password: String) async throws -> Account
    func register(email: String, password: String, name: String?) async throws -> Account
    func deleteAccount() async throws
}
