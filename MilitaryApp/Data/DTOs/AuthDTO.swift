//
//  AuthDTO.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Response from `/auth/login` and `/auth/register`.
struct LoginResponse: Decodable {
    let accessToken: String
    let refreshToken: String?
    let user: ProfileDTO
}
