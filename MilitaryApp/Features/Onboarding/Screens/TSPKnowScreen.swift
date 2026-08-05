//
//  TSPKnowScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Asks whether the member knows their TSP balance (serving members only).
struct TSPKnowScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OBTitle(title: "Do you know your TSP balance?",
                    subtitle: "No stress. You can check it anytime inside the app.")
                .padding(.top, 8)
            VStack(spacing: 14) {
                OptionButton(title: "Yes", selected: onboarding.profile.knowsTSP == true) {
                    selectThenAdvance({ onboarding.profile.knowsTSP = true }, onNext)
                }
                OptionButton(title: "No", selected: onboarding.profile.knowsTSP == false) {
                    selectThenAdvance({ onboarding.profile.knowsTSP = false }, onNext)
                }
            }
            Spacer()
        }
        .obPadding().padding(.top, 24)
    }
}
