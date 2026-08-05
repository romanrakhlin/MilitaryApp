//
//  ValorBackground.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Full-screen white background with a soft blue glow rising from the top,
/// matching the Valor light-theme look.
struct ValorBackground: View {
    var glow: Bool = true

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            if glow {
                RadialGradient(
                    colors: [Valor.blue.opacity(0.06), .clear],
                    center: .init(x: 0.5, y: -0.05),
                    startRadius: 10,
                    endRadius: 420
                )
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ZStack {
        ValorBackground()
        Text("Valor")
            .font(.valorTitle(48))
            .foregroundStyle(Valor.blue)
    }
}
