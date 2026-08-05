//
//  TrackedValueCard.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The hero "benefits tracked" card with the total value and four tiles.
struct TrackedValueCard: View {
    let summary: HomeSummary?
    let estimatedAnnualValue: Int

    private func money(_ cents: Int) -> String {
        "$" + (cents / 100).formatted(.number.grouping(.automatic))
    }

    var body: some View {
        VStack(spacing: 18) {
            VStack(spacing: 4) {
                Text("BENEFITS TRACKED")
                    .font(.valorFont(13, weight: .heavy))
                    .foregroundStyle(Valor.blue)
                    .tracking(1.5)
                Text(summary.map { money($0.benefitsTracked.totalCents) }
                     ?? "$\(estimatedAnnualValue.formatted(.number.grouping(.automatic)))")
                    .font(.valorFont(48, weight: .black))
                    .foregroundStyle(Valor.textPrimary)
                    .minimumScaleFactor(0.6).lineLimit(1)
                Text("across \(summary?.benefitsTracked.acrossCount ?? 2) benefits")
                    .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
            }

            HStack(spacing: 12) {
                BenefitTile(title: "Cards", value: summary?.tiles.cards.valueDisplay ?? "---",
                            sub: summary?.tiles.cards.cta ?? "Tap to add", icon: "creditcard.fill", tint: Valor.blue)
                BenefitTile(title: "Income", value: summary?.tiles.income.valueDisplay ?? "$28,769",
                            sub: nil, icon: "dollarsign", tint: Color.orange)
            }
            HStack(spacing: 12) {
                BenefitTile(title: "TSP", value: summary?.tiles.tsp.valueDisplay ?? "$262",
                            sub: nil, icon: "chart.line.uptrend.xyaxis", tint: Valor.green)
                BenefitTile(title: "Perks", value: summary?.tiles.perks.valueDisplay ?? "10,000+",
                            sub: summary?.tiles.perks.subtitle ?? "available in this app", icon: "sparkles", tint: Valor.red)
            }
        }
        .padding(18)
        .background(RoundedRectangle(cornerRadius: 24).fill(Valor.blue.opacity(0.05)))
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(Valor.blue.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: Valor.blue.opacity(0.12), radius: 24, y: 6)
    }
}
