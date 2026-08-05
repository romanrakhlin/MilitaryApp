//
//  HomeRepository.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Home dashboard port.
protocol HomeRepository {
    func home() async throws -> HomeSummary
}
