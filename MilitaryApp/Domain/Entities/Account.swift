//
//  Account.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// An authenticated user: identity + onboarding state + their profile.
/// Returned by the auth and profile repositories.
struct Account {
    let id: String
    let email: String?
    let onboardingComplete: Bool
    var profile: UserProfile
}
