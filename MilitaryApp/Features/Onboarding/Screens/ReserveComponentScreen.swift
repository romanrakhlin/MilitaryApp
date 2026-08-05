//
//  ReserveComponentScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Reserve vs National Guard (only shown to Reserves / Guard members).
struct ReserveComponentScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OBTitle(title: "Are you in the Reserve or National Guard?").padding(.top, 8)
            VStack(spacing: 14) {
                ForEach(ReserveComponent.allCases) { c in
                    OptionButton(title: c.rawValue,
                                 selected: onboarding.profile.reserveComponent == c) {
                        selectThenAdvance({ onboarding.profile.reserveComponent = c }, onNext)
                    }
                }
            }
            Spacer()
        }
        .obPadding().padding(.top, 24)
    }
}
