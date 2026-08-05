//
//  ProfileRepository.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Profile port: read the current account, persist onboarding answers, and
/// mark onboarding complete.
protocol ProfileRepository {
    func me() async throws -> Account
    func update(_ profile: UserProfile) async throws -> Account
    func completeOnboarding() async throws
}
