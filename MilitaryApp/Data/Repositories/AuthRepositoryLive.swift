//
//  AuthRepositoryLive.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Live authentication over the backend. Persists the returned tokens to the
/// injected `TokenStore` as a side effect.
struct AuthRepositoryLive: AuthRepository {
    let api: APIClient
    let tokens: TokenStore

    private struct AuthBody: Encodable { let email: String; let password: String; let name: String? }

    func login(email: String, password: String) async throws -> Account {
        try await authenticate(path: "/auth/login",
                               body: AuthBody(email: email, password: password, name: nil))
    }

    func register(email: String, password: String, name: String?) async throws -> Account {
        try await authenticate(path: "/auth/register",
                               body: AuthBody(email: email, password: password, name: name))
    }

    private func authenticate(path: String, body: AuthBody) async throws -> Account {
        let res: LoginResponse = try await api.post(path, body, authorized: false)
        tokens.accessToken = res.accessToken
        tokens.refreshToken = res.refreshToken
        return ProfileMapper.account(from: res.user)
    }
}
