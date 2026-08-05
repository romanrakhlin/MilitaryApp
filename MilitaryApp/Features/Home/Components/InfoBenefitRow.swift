//
//  InfoBenefitRow.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A row in the "Perks & Discounts" section: provider name, one-line blurb,
/// and its discount badge. Tapping opens the detail sheet.
struct InfoBenefitRow: View {
    let benefit: InfoBenefit
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(benefit.name).font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                    Text(benefit.blurb)
                        .font(.valorBody(13)).foregroundStyle(Valor.textSecondary)
                        .lineLimit(1)
                }
                Spacer(minLength: 8)
                Text(benefit.badge)
                    .font(.valorFont(12, weight: .bold)).foregroundStyle(Valor.green)
                    .padding(.horizontal, 10).padding(.vertical, 6)
                    .background(Capsule().fill(Valor.green.opacity(0.12)))
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Valor.textTertiary)
            }
            .padding(.horizontal, 14).padding(.vertical, 12)
            .background(RoundedRectangle(cornerRadius: 16).fill(Valor.card.opacity(0.5)))
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Valor.cardStroke))
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
