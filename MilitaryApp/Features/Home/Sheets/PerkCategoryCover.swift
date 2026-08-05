//
//  PerkCategoryCover.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Fullscreen browser for one perk category: every brand with its full
/// benefit description and a link out to the official page.
struct PerkCategoryCover: View {
    let category: InfoBenefitCategory
    let benefits: [InfoBenefit]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(spacing: 14) {
                            Image(systemName: category.icon)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundStyle(category.tint)
                                .frame(width: 52, height: 52)
                                .background(Circle().fill(category.tint.opacity(0.13)))
                            VStack(alignment: .leading, spacing: 2) {
                                Text(category.rawValue)
                                    .font(.valorTitle(28)).foregroundStyle(Valor.textPrimary)
                                Text("\(benefits.count) military benefits")
                                    .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
                            }
                        }
                        .padding(.bottom, 6)

                        ForEach(benefits) { benefit in
                            benefitCard(benefit)
                        }
                        Color.clear.frame(height: 24)
                    }
                    .padding(20)
                }
                .scrollIndicators(.hidden)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(Valor.textSecondary)
                            .frame(width: 30, height: 30)
                            .background(Circle().fill(Valor.card))
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }

    private func benefitCard(_ benefit: InfoBenefit) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(benefit.name)
                    .font(.valorButton(17)).foregroundStyle(Valor.textPrimary)
                Spacer(minLength: 8)
                Text(benefit.badge)
                    .font(.valorFont(12, weight: .bold)).foregroundStyle(Valor.green)
                    .padding(.horizontal, 10).padding(.vertical, 6)
                    .background(Capsule().fill(Valor.green.opacity(0.12)))
            }
            Text(benefit.blurb)
                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
            if let url = URL(string: benefit.urlString) {
                Link(destination: url) {
                    HStack(spacing: 6) {
                        Text("Visit official website")
                        Image(systemName: "arrow.up.right")
                    }
                    .font(.valorFont(14, weight: .bold)).foregroundStyle(Valor.blue)
                    .padding(.horizontal, 14).padding(.vertical, 9)
                    .background(Capsule().fill(Valor.blue.opacity(0.10)))
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .homeCardSurface()
    }
}
