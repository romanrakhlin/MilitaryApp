//
//  InfoBenefitDetailSheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Detail sheet for an informational perk: what the benefit is and a link out
/// to the provider's official page.
struct InfoBenefitDetailSheet: View {
    let benefit: InfoBenefit
    @Environment(\.dismiss) private var dismiss

    private var categoryIcon: String {
        switch benefit.category {
        case .airlines: return "airplane"
        case .hotels: return "bed.double.fill"
        case .shopping: return "bag.fill"
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 14) {
                        Image(systemName: categoryIcon)
                            .font(.system(size: 22)).foregroundStyle(Valor.blue)
                            .frame(width: 52, height: 52)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Valor.blue.opacity(0.12)))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(benefit.name).font(.valorTitle(26)).foregroundStyle(Valor.textPrimary)
                            Text(benefit.category.rawValue.uppercased())
                                .font(.valorFont(12, weight: .heavy))
                                .foregroundStyle(Valor.textTertiary).tracking(1)
                        }
                    }

                    Text(benefit.badge)
                        .font(.valorFont(13, weight: .bold)).foregroundStyle(Valor.green)
                        .padding(.horizontal, 12).padding(.vertical, 7)
                        .background(Capsule().fill(Valor.green.opacity(0.12)))

                    Text(benefit.blurb)
                        .font(.valorBody(16)).foregroundStyle(Valor.textSecondary)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()

                    if let url = URL(string: benefit.urlString) {
                        Link(destination: url) {
                            HStack(spacing: 8) {
                                Text("Visit official website")
                                Image(systemName: "arrow.up.right")
                            }
                            .font(.valorButton(17)).foregroundStyle(.white)
                            .frame(maxWidth: .infinity).padding(.vertical, 16)
                            .background(RoundedRectangle(cornerRadius: 16).fill(Valor.blue))
                        }
                    }
                }
                .padding(20)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }.foregroundStyle(Valor.blue)
                }
            }
        }
        .preferredColorScheme(.light)
        .presentationDetents([.medium])
    }
}
