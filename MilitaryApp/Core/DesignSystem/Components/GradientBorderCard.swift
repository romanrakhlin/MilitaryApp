//
//  GradientBorderCard.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A card with a gradient hairline border and soft glow (qualify summary).
struct GradientBorderCard<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(22)
            .background(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .fill(Valor.card.opacity(0.7))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22, style: .continuous)
                    .strokeBorder(Valor.brandGradient, lineWidth: 1.5)
            )
            .shadow(color: Valor.blue.opacity(0.25), radius: 24, y: 6)
    }
}
