//
//  BenefitTotalCard.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The hero card at the top of Home: total annual value across every benefit
/// the user has set up below. Solid brand-gradient surface, no border.
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
                .foregroundStyle(.white.opacity(0.85))
                .tracking(1.5)
            Text(MoneyText.usd(totalCents))
                .font(.valorFont(52, weight: .black))
                .foregroundStyle(.white)
                .minimumScaleFactor(0.6).lineLimit(1)
                .contentTransition(.numericText())
            Text(caption)
                .font(.valorBody(14)).foregroundStyle(.white.opacity(0.85))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 32).padding(.horizontal, 18)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(LinearGradient(colors: [Color(red: 0.10, green: 0.42, blue: 1.0), Valor.blue,
                                              Color(red: 0.0, green: 0.22, blue: 0.75)],
                                     startPoint: .topLeading, endPoint: .bottomTrailing))
                // Soft light falling across the card from the top left.
                .overlay(
                    RadialGradient(colors: [.white.opacity(0.25), .clear],
                                   center: .topLeading, startRadius: 0, endRadius: 300)
                )
                .overlay(alignment: .topTrailing) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 96, weight: .bold))
                        .foregroundStyle(.white.opacity(0.09))
                        .rotationEffect(.degrees(-10))
                        .offset(x: 18, y: -14)
                }
                .clipShape(RoundedRectangle(cornerRadius: 28))
                // Layered accent glow: a tight core plus a wide soft halo.
                .shadow(color: Valor.blue.opacity(0.45), radius: 16, y: 8)
                .shadow(color: Valor.blue.opacity(0.22), radius: 38, y: 18)
        )
    }
}
