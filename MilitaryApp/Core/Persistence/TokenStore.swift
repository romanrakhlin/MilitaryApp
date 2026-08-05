//
//  TokenStore.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Persists the access / refresh tokens for the session.
///
/// Dev: backed by `UserDefaults`. Move to the Keychain for production.
/// Conforms to the Domain `SessionTokens` port so use cases can query / clear
/// the session without depending on this concrete type.
final class TokenStore: SessionTokens {

    private enum Keys { static let access = "valor.access"; static let refresh = "valor.refresh" }

    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: Keys.access) }
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.access) }
    }
    var refreshToken: String? {
        get { UserDefaults.standard.string(forKey: Keys.refresh) }
        set { UserDefaults.standard.setValue(newValue, forKey: Keys.refresh) }
    }

    var hasSession: Bool { accessToken != nil }

    func clear() { accessToken = nil; refreshToken = nil }
}
