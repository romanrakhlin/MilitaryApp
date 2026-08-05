//
//  StateBenefitListScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Benefits for one state (or the federal all-states set), pushed from the
/// State Benefits directory.
struct StateBenefitListScreen: View {
    let title: String
    let subtitle: String
    let benefits: [StateBenefit]

    var body: some View {
        ZStack {
            ValorBackground(glow: false)
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.valorTitle(28)).foregroundStyle(Valor.textPrimary)
                        Text(subtitle)
                            .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
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
        .navigationBarTitleDisplayMode(.inline)
    }
}
