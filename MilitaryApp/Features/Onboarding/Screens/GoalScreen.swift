//
//  GoalScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Captures the member's primary goal.
struct GoalScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OBTitle(title: "What do you want most?").padding(.top, 8)
            VStack(spacing: 14) {
                ForEach(PrimaryGoal.allCases) { goal in
                    OptionButton(title: goal.rawValue,
                                 selected: onboarding.profile.goal == goal) {
                        selectThenAdvance({ onboarding.profile.goal = goal }, onNext)
                    }
                }
            }
            Spacer()
        }
        .obPadding().padding(.top, 24)
    }
}
