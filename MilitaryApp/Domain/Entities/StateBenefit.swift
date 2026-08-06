//
//  StateBenefit.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// One benefit inside a state (or the federal) benefits guide, with a link
/// out to the official page.
struct StateBenefit: Identifiable, Hashable {
    let name: String
    let badge: String
    let blurb: String
    let urlString: String

    var id: String { name }
}
