//
//  ValorColors.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The Valor color palette (light theme): white surfaces + a #0053FF blue accent.
/// Extended with gradients in `ValorGradients.swift`.
enum Valor {

    // Core surfaces (light theme)
    static let bgTop = Color.white
    static let bgMid = Color.white
    static let bgBottom = Color.white

    /// Subtle card surface on white, defined mostly by its hairline border.
    static let card = Color(red: 0.95, green: 0.96, blue: 0.98)       // #F2F5FA
    static let cardStroke = Color.black.opacity(0.08)

    // Brand accents
    static let blue = Color("ValorBlue")                             // #0053FF (asset)
    static let red = Color(red: 0.83, green: 0.19, blue: 0.25)        // reserved accent
    static let green = Color(red: 0.10, green: 0.70, blue: 0.42)      // status green

    // Text (dark on white)
    static let textPrimary = Color(red: 0.05, green: 0.07, blue: 0.12)   // near-black
    static let textSecondary = Color(red: 0.38, green: 0.42, blue: 0.50)
    static let textTertiary = Color(red: 0.60, green: 0.64, blue: 0.70)
}
