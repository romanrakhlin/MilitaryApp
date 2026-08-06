//
//  StateGuide.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Everything one U.S. state offers its veterans: the state identity plus its
/// list of benefits.
struct StateGuide: Identifiable, Hashable {
    let name: String
    let abbreviation: String
    let benefits: [StateBenefit]

    var id: String { abbreviation }
}
