//
//  ProfileRepositoryLive.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Live profile access over the backend.
struct ProfileRepositoryLive: ProfileRepository {
    let api: APIClient

    func me() async throws -> Account {
        let dto: ProfileDTO = try await api.get("/me")
        return ProfileMapper.account(from: dto)
    }

    func update(_ profile: UserProfile) async throws -> Account {
        let dto: ProfileDTO = try await api.patch("/me", ProfileMapper.patch(from: profile))
        return ProfileMapper.account(from: dto)
    }

    func completeOnboarding() async throws {
        _ = try await api.post("/onboarding/complete", Empty()) as Empty
    }
}
