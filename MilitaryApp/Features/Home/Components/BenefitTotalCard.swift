//
//  BenefitTotalCard.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The hero card at the top of Home: total annual value across every benefit
/// the user has set up below.
struct BenefitTotalCard: View {
    let totalCents: Int
    let benefitCount: Int

    private var caption: String {
        benefitCount == 0
            ? "Set up your benefits below to start tracking"
            : "across \(benefitCount) benefit\(benefitCount == 1 ? "" : "s") · per year"
    }

    var body: some View {
        VStack(spacing: 6) {
            Text("BENEFITS TRACKED")
                .font(.valorFont(13, weight: .heavy))
                .foregroundStyle(Valor.blue)
                .tracking(1.5)
            Text(MoneyText.usd(totalCents))
                .font(.valorFont(52, weight: .black))
                .foregroundStyle(Valor.textPrimary)
                .minimumScaleFactor(0.6).lineLimit(1)
                .contentTransition(.numericText())
            Text(caption)
                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28).padding(.horizontal, 18)
        .background(RoundedRectangle(cornerRadius: 24).fill(Valor.blue.opacity(0.05)))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(Valor.blue.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: Valor.blue.opacity(0.12), radius: 24, y: 6)
    }
}
