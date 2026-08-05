//
//  NationalChain.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// A national brand offering a military discount, shown in the Chains sheet.
struct NationalChain: Identifiable {
    let id = UUID()
    let name: String
    let category: DiscountCategory
    let blurb: String
    let locations: Int
    var discountBadge: String?
}
