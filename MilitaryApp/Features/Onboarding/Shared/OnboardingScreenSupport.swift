//
//  OnboardingScreenSupport.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

extension View {
    /// Standard horizontal insets for onboarding content.
    func obPadding() -> some View { self.padding(.horizontal, 24) }
}

/// Helper for auto-advancing choice screens: apply the selection with a brief
/// highlight, then move on.
@MainActor
func selectThenAdvance(_ perform: @escaping () -> Void, _ onNext: @escaping () -> Void) {
    withAnimation { perform() }
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) { onNext() }
}
