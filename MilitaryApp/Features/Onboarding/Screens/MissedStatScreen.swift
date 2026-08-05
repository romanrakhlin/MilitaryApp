//
//  MissedStatScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// An unclaimed-benefits stat, framed for whoever is onboarding.
struct MissedStatScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void

    /// The copy matches the status the member picked rather than always
    /// Reserve/Guard.
    private var headline: String {
        switch onboarding.profile.status {
        case .reservesGuard:
            return "Reserve and Guard members miss an estimated $3,600 a year in benefits they never claimed."
        case .veteran, .retiree:
            return "Veterans leave an estimated $2,900 a year in earned benefits unclaimed."
        case .dependent:
            return "Military families miss an estimated $2,400 a year in benefits they qualify for."
        default:
            return "Service members miss an estimated $3,600 a year in benefits they never claimed."
        }
    }

    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "star.fill")
                .font(.system(size: 30))
                .foregroundStyle(.white)
                .frame(width: 64, height: 64)
                .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(Valor.brandGradient))
                .shadow(color: Valor.blue.opacity(0.3), radius: 16, y: 8)
                .padding(.bottom, 24)
            Text(headline)
                .font(.valorTitle(30))
                .foregroundStyle(Valor.textPrimary)
                .multilineTextAlignment(.center)
                .obPadding()
            Text("Let's make sure you're getting everything you've earned.")
                .font(.valorBody(17))
                .foregroundStyle(Valor.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.top, 12).obPadding()
            Spacer()
            PrimaryButton(title: "Show me", action: onNext).obPadding().padding(.bottom, 20)
        }
    }
}
