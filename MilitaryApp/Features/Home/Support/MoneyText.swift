//
//  MoneyText.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Dollar formatting for the benefits dashboard (whole dollars, grouped).
enum MoneyText {
    static func usd(_ cents: Int) -> String {
        "$" + (cents / 100).formatted(.number.grouping(.automatic))
    }
}
