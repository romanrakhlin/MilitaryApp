//
//  DescribeScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Captures the member's status — the answer that shapes the rest of the flow.
struct DescribeScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OBTitle(title: "Which best\ndescribes you?", alignment: .center).padding(.top, 8)
            VStack(spacing: 14) {
                ForEach(MilitaryStatus.allCases) { status in
                    OptionButton(title: status.rawValue,
                                 selected: onboarding.profile.status == status) {
                        selectThenAdvance({ onboarding.profile.status = status }, onNext)
                    }
                }
            }
            Spacer()
        }
        .obPadding().padding(.top, 24)
    }
}
