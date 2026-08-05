//
//  OnboardingHeader.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Onboarding chrome: a back button (hidden on the first step) plus the
/// progress bar.
struct OnboardingHeader: View {
    var progress: Double
    var showBack: Bool
    var onBack: () -> Void

    var body: some View {
        HStack(spacing: 14) {
            Button {
                Haptics.impact(.light)
                onBack()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Valor.textPrimary)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Valor.card))
                    .overlay(Circle().strokeBorder(Valor.cardStroke))
                    .shadow(color: Color.black.opacity(0.05), radius: 4, y: 2)
            }
            .buttonStyle(ScaleButtonStyle(scale: 0.9))
            .opacity(showBack ? 1 : 0)
            .disabled(!showBack)
            .accessibilityLabel("Back")

            ValorProgressBar(progress: progress)
        }
        .padding(.horizontal, 20)
        .padding(.top, 6)
    }
}
