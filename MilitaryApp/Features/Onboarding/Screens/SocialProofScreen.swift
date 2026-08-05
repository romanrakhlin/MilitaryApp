//
//  SocialProofScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Member-count social proof.
struct SocialProofScreen: View {
    let onNext: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Text("143,607")
                .font(.valorFont(64, weight: .black))
                .foregroundStyle(Valor.textPrimary)
                .minimumScaleFactor(0.6)
                .lineLimit(1)
            Text("members and growing.")
                .font(.valorTitle(30))
                .foregroundStyle(Valor.textPrimary)
            Text("Active duty, veterans, retirees, and military families already maximizing what they've earned.")
                .font(.valorBody(17))
                .foregroundStyle(Valor.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 10)
                .obPadding()

            HStack(spacing: 8) {
                Image(systemName: "chart.line.uptrend.xyaxis")
                    .foregroundStyle(Valor.blue)
                Text("+1,300").bold().foregroundStyle(Valor.textPrimary)
                Text("joining on avg / day").foregroundStyle(Valor.textSecondary)
            }
            .font(.valorBody(15))
            .padding(.horizontal, 20).padding(.vertical, 12)
            .background(Capsule().fill(Valor.card.opacity(0.7)))
            .padding(.top, 24)

            Spacer()
            PrimaryButton(title: "Continue", action: onNext).obPadding().padding(.bottom, 20)
        }
    }
}
