//
//  APIError.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// A decoded transport / server error surfaced to the UI.
struct APIError: LocalizedError {
    let status: Int
    let code: String?
    let message: String
    var errorDescription: String? { message }
}

/// The backend's `{ "error": { "code", "message" } }` envelope.
struct ServerError: Decodable {
    struct Inner: Decodable { let code: String?; let message: String? }
    let error: Inner
}
