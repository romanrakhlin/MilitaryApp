//
//  MilitaryCreditCard.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// A premium credit card whose annual fee is waived for service members under
/// MLA/SCRA. Selecting held cards adds the waived fees to the tracked total.
struct MilitaryCreditCard: Identifiable, Equatable {
    let id: String
    let name: String
    let issuer: String
    let annualFeeCents: Int
    let blurb: String
}
