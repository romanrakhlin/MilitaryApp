//
//  ValorGradients.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

extension Valor {

    /// The primary blue brand gradient (buttons, progress, accents).
    static let brandGradient = LinearGradient(
        colors: [blue, Color(red: 0.18, green: 0.45, blue: 1.0)],
        startPoint: .leading,
        endPoint: .trailing
    )

    /// Flat white background wash.
    static let backgroundWash = LinearGradient(
        colors: [bgTop, bgBottom],
        startPoint: .top,
        endPoint: .bottom
    )
}
