//
//  TrackableBenefitRow.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A row in the "Your Benefits" section. Unconfigured kinds show a "Set up"
/// call-to-action; configured ones show their annual value and summary.
struct TrackableBenefitRow: View {
    let kind: TrackedBenefitKind
    let entry: TrackedBenefitEntry?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: kind.icon)
                    .font(.system(size: 18)).foregroundStyle(kind.tint)
                    .frame(width: 44, height: 44)
                    .background(RoundedRectangle(cornerRadius: 13).fill(kind.tint.opacity(0.14)))

                VStack(alignment: .leading, spacing: 3) {
                    Text(kind.title).font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                    Text(entry?.detail ?? kind.subtitle)
                        .font(.valorBody(13)).foregroundStyle(Valor.textSecondary)
                        .lineLimit(1)
                }
                Spacer(minLength: 8)

                if let entry {
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(MoneyText.usd(entry.annualValueCents))
                            .font(.valorFont(17, weight: .black)).foregroundStyle(Valor.textPrimary)
                        Text("/ year").font(.valorBody(11)).foregroundStyle(Valor.textTertiary)
                    }
                } else {
                    Text("Set up")
                        .font(.valorFont(13, weight: .bold)).foregroundStyle(Valor.blue)
                        .padding(.horizontal, 12).padding(.vertical, 7)
                        .background(Capsule().fill(Valor.blue.opacity(0.12)))
                }
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Valor.textTertiary)
            }
            .padding(14)
            .background(RoundedRectangle(cornerRadius: 18).fill(Valor.card.opacity(0.5)))
            .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.cardStroke))
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
