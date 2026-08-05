//
//  HomeRepositoryLive.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Live Home dashboard access over the backend.
struct HomeRepositoryLive: HomeRepository {
    let api: APIClient

    func home() async throws -> HomeSummary {
        let dto: HomeDTO = try await api.get("/home")
        return HomeMapper.summary(from: dto)
    }
}
