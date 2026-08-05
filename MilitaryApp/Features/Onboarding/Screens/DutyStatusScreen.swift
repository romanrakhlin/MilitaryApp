//
//  DutyStatusScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Current duty status (only shown to Reserves / Guard members).
struct DutyStatusScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OBTitle(title: "What's your current duty status?").padding(.top, 8)
            VStack(spacing: 14) {
                ForEach(DutyStatus.allCases) { s in
                    OptionButton(title: s.rawValue,
                                 selected: onboarding.profile.dutyStatus == s) {
                        selectThenAdvance({ onboarding.profile.dutyStatus = s }, onNext)
                    }
                }
            }
            Spacer()
        }
        .obPadding().padding(.top, 24)
    }
}
