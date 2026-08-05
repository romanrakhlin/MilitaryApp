//
//  InfoBenefit.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// An informational benefit (airline, hotel, retailer…) the user can read
/// about and follow through to the provider's official page.
struct InfoBenefit: Identifiable, Equatable {
    let name: String
    let category: InfoBenefitCategory
    let badge: String
    let blurb: String
    let urlString: String

    var id: String { name }
}
