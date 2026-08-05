//
//  TSPFund.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The Thrift Savings Plan funds a member can allocate across.
enum TSPFund: String, CaseIterable, Codable, Identifiable {
    case g = "G Fund", f = "F Fund", c = "C Fund", s = "S Fund", i = "I Fund", l = "L Fund"
    var id: String { rawValue }

    var subtitle: String {
        switch self {
        case .g: return "Government Securities"
        case .f: return "Fixed Income"
        case .c: return "Common Stock"
        case .s: return "Small Cap Stock"
        case .i: return "International Stock"
        case .l: return "Lifecycle"
        }
    }
}
