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
                            BenefitLinkCard(name: benefit.name, badge: benefit.badge,
                                            blurb: benefit.blurb, urlString: benefit.urlString)
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
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }
}
