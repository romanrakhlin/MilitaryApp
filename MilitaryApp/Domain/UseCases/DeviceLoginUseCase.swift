//
//  DeviceLoginUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Signs the install in anonymously using its stable device ID, so
/// authenticated endpoints (places, profile) work from the very first launch —
/// before, or without, any explicit account.
struct DeviceLoginUseCase {
    let repository: AuthRepository

    func callAsFunction(deviceId: String) async throws -> Account {
        try await repository.deviceLogin(deviceId: deviceId)
    }
}
