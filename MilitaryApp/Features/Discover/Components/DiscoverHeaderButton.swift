//
//  DiscoverHeaderButton.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A round frosted icon button in the Discover header (filter left, search
/// right). Sized to match the 42pt tab switcher, with an optional blue badge
/// for the active-filter count.
struct DiscoverHeaderButton: View {
    let icon: String
    /// Spoken name for VoiceOver — the button itself is icon-only.
    let title: String
    var badgeCount: Int = 0
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Valor.textPrimary)
                .frame(width: 42, height: 42)
                .background(Circle().fill(.regularMaterial))
                .overlay(Circle().strokeBorder(Valor.cardStroke))
                .overlay(alignment: .topTrailing) {
                    if badgeCount > 0 {
                        Text("\(badgeCount)")
                            .font(.valorFont(10, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 16, height: 16)
                            .background(Circle().fill(Valor.blue))
                            .offset(x: 2, y: -2)
                    }
                }
                .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
        }
        .buttonStyle(ScaleButtonStyle())
        .accessibilityLabel(title)
    }
}
