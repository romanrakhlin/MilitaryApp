//
//  LoadHomeUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Loads the Home dashboard summary.
struct LoadHomeUseCase {
    let repository: HomeRepository

    func callAsFunction() async throws -> HomeSummary {
        try await repository.home()
    }
}
