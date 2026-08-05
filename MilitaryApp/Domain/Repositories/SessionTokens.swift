//
//  SessionTokens.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Port describing the session-token store the domain depends on, without
/// knowing where or how the tokens are persisted. Implemented by `TokenStore`.
protocol SessionTokens: AnyObject {
    var hasSession: Bool { get }
    func clear()
}
