//
//  BenefitLinkCard.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Card for one linkable benefit: name, badge, description, and a link out
/// to the official page. Shared by the perk-category and state browsers.
struct BenefitLinkCard: View {
    let name: String
    let badge: String
    let blurb: String
    let urlString: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                Text(name)
                    .font(.valorButton(17)).foregroundStyle(Valor.textPrimary)
                Spacer(minLength: 8)
                Text(badge)
                    .font(.valorFont(12, weight: .bold)).foregroundStyle(Valor.green)
                    .padding(.horizontal, 10).padding(.vertical, 6)
                    .background(Capsule().fill(Valor.green.opacity(0.12)))
            }
            Text(blurb)
                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
            if let url = URL(string: urlString) {
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
