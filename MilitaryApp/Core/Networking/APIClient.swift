//
//  APIClient.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Thin async JSON client for the Valor backend. Handles the base URL,
/// bearer auth, snake_case <-> camelCase coding, and one automatic token
/// refresh on 401. Token storage is delegated to an injected `TokenStore`.
final class APIClient {

    // Production backend (Railway). Points here for both simulator and device.
    let baseURL = "https://military-app.up.railway.app/v1"

    // To develop against a local backend instead, swap the line above for a
    // localhost / LAN base URL.

    private let session = URLSession.shared
    private let tokens: TokenStore

    init(tokens: TokenStore) {
        self.tokens = tokens
    }

    // MARK: Coders

    private let decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.keyDecodingStrategy = .convertFromSnakeCase
        return d
    }()
    private let encoder: JSONEncoder = {
        let e = JSONEncoder()
        e.keyEncodingStrategy = .convertToSnakeCase
        return e
    }()

    /// Encode an arbitrary body for callers that build requests via a repository.
    func encode<B: Encodable>(_ body: B) throws -> Data { try encoder.encode(body) }

    // MARK: Public verbs

    func get<T: Decodable>(_ path: String, authorized: Bool = true) async throws -> T {
        try await send(method: .get, path: path, body: nil, authorized: authorized)
    }

    func post<T: Decodable, B: Encodable>(_ path: String, _ body: B, authorized: Bool = true) async throws -> T {
        try await send(method: .post, path: path, body: try encoder.encode(body), authorized: authorized)
    }

    func patch<T: Decodable, B: Encodable>(_ path: String, _ body: B, authorized: Bool = true) async throws -> T {
        try await send(method: .patch, path: path, body: try encoder.encode(body), authorized: authorized)
    }

    func delete<T: Decodable>(_ path: String, authorized: Bool = true) async throws -> T {
        try await send(method: .delete, path: path, body: nil, authorized: authorized)
    }

    // MARK: Core

    private func send<T: Decodable>(method: HTTPMethod, path: String, body: Data?, authorized: Bool,
                                    isRetry: Bool = false) async throws -> T {
        let data = try await raw(method: method, path: path, body: body, authorized: authorized, isRetry: isRetry)
        if T.self == Empty.self { return Empty() as! T }
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            print("⚠️ Valor decode error on \(method.rawValue) \(path): \(error)")
            throw error
        }
    }

    private func raw(method: HTTPMethod, path: String, body: Data?, authorized: Bool,
                     isRetry: Bool) async throws -> Data {
        guard let url = URL(string: baseURL + path) else {
            throw APIError(status: -1, code: "bad_url", message: "Invalid URL: \(path)")
        }
        var req = URLRequest(url: url)
        req.httpMethod = method.rawValue
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if authorized, let token = tokens.accessToken {
            req.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        req.httpBody = body

        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await session.data(for: req)
        } catch {
            print("⚠️ Valor network error on \(method.rawValue) \(path): \(error.localizedDescription)")
            throw APIError(status: -1, code: "network", message: error.localizedDescription)
        }
        let http = response as! HTTPURLResponse
        print("→ \(method.rawValue) \(path) [\(http.statusCode)]")

        if http.statusCode == 401, authorized, !isRetry, tokens.refreshToken != nil {
            if await tryRefresh() {
                return try await raw(method: method, path: path, body: body, authorized: authorized, isRetry: true)
            }
        }

        guard (200..<300).contains(http.statusCode) else {
            let apiErr = try? decoder.decode(ServerError.self, from: data)
            throw APIError(status: http.statusCode,
                           code: apiErr?.error.code,
                           message: apiErr?.error.message ?? "Request failed (\(http.statusCode))")
        }
        return data
    }

    private func tryRefresh() async -> Bool {
        guard let refresh = tokens.refreshToken else { return false }
        struct Body: Encodable { let refreshToken: String }
        struct Res: Decodable { let accessToken: String; let refreshToken: String? }
        do {
            let res: Res = try await send(method: .post, path: "/auth/refresh",
                                          body: try encoder.encode(Body(refreshToken: refresh)),
                                          authorized: false, isRetry: true)
            tokens.accessToken = res.accessToken
            if let r = res.refreshToken { tokens.refreshToken = r }
            return true
        } catch {
            tokens.clear()
            return false
        }
    }
}
