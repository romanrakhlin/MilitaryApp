//
//  BranchScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Captures the member's service branch.
struct BranchScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OBTitle(title: "What branch are you in?").padding(.top, 8)
            VStack(spacing: 14) {
                ForEach(Branch.allCases) { branch in
                    OptionButton(title: branch.rawValue,
                                 selected: onboarding.profile.branch == branch) {
                        selectThenAdvance({ onboarding.profile.branch = branch }, onNext)
                    }
                }
            }
            Spacer()
        }
        .obPadding().padding(.top, 24)
    }
}
