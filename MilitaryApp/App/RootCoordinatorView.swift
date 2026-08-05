//
//  RootCoordinatorView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Top-level switch between onboarding and the main tabbed app, driven by the
/// shared `SessionStore`.
struct RootCoordinatorView: View {
    @EnvironmentObject private var session: SessionStore
    let container: AppContainer

    /// TESTING ONLY — set to `false` to restore the normal onboarding flow.
    private let skipOnboardingForTesting = true

    var body: some View {
        Group {
            if skipOnboardingForTesting || session.hasCompletedOnboarding {
                MainTabView(container: container)
                    .transition(.opacity)
            } else {
                OnboardingCoordinatorView(container: container)
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: session.hasCompletedOnboarding)
        .task { await session.bootstrap() }
    }
}
