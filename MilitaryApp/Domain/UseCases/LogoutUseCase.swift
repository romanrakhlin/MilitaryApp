//
//  LogoutUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Clears the stored session.
struct LogoutUseCase {
    let tokens: SessionTokens

    func callAsFunction() {
        tokens.clear()
    }
}
