//
//  ProUpgradeSheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Lightweight Valor Pro paywall presented from the settings menu.
struct ProUpgradeSheet: View {
    @Environment(\.dismiss) private var dismiss

    private let perks: [(String, String)] = [
        ("infinity", "Track unlimited benefits"),
        ("chart.line.uptrend.xyaxis", "Advanced calculators and projections"),
        ("bell.badge.fill", "Alerts when new benefits match your profile"),
        ("star.fill", "Early access to new tools")
    ]

    var body: some View {
        ZStack {
            ValorBackground(glow: false)
            VStack(spacing: 24) {
                Capsule().fill(Valor.cardStroke).frame(width: 40, height: 5).padding(.top, 10)

                Image(systemName: "crown.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.white)
                    .frame(width: 80, height: 80)
                    .background(
                        Circle()
                            .fill(LinearGradient(colors: [Valor.blue, Color(red: 0.0, green: 0.22, blue: 0.75)],
                                                 startPoint: .topLeading, endPoint: .bottomTrailing))
                            .shadow(color: Valor.blue.opacity(0.35), radius: 18, y: 8)
                    )

                VStack(spacing: 6) {
                    Text("Valor Pro").font(.valorTitle(30)).foregroundStyle(Valor.textPrimary)
                    Text("Get every dollar you've earned")
                        .font(.valorBody(15)).foregroundStyle(Valor.textSecondary)
                }

                VStack(alignment: .leading, spacing: 14) {
                    ForEach(perks, id: \.1) { icon, text in
                        HStack(spacing: 12) {
                            Image(systemName: icon)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Valor.blue)
                                .frame(width: 26)
                            Text(text).font(.valorBody(15)).foregroundStyle(Valor.textPrimary)
                        }
                    }
                }
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .homeCardSurface()

                Spacer()

                Button {
                    Haptics.success()
                    dismiss()
                } label: {
                    Text("Start Free Trial")
                        .font(.valorButton(17)).foregroundStyle(.white)
                        .frame(maxWidth: .infinity).padding(.vertical, 16)
                        .background(RoundedRectangle(cornerRadius: 16).fill(Valor.blue))
                }
                Text("7 days free, then $4.99/month. Cancel anytime.")
                    .font(.valorBody(12)).foregroundStyle(Valor.textTertiary)
                    .padding(.bottom, 8)
            }
            .padding(.horizontal, 20)
        }
        .preferredColorScheme(.light)
        .presentationDetents([.large])
    }
}
