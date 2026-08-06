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
    private let skipOnboardingForTesting = false

    @State private var showPostOnboardingPaywall = false

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
        .fullScreenCover(isPresented: $showPostOnboardingPaywall) { PaywallScreen() }
        .onChange(of: session.hasCompletedOnboarding) { wasComplete, isComplete in
            // Fires only on the live onboarding → main-app transition (a
            // restored session already starts out `true`, so no cover there).
            // Suppressed in skip-onboarding testing mode, where the dev
            // auto-sign-in completes onboarding on every boot — use
            // `-showPaywall` to test the paywall there instead.
            if isComplete && !wasComplete && !skipOnboardingForTesting && !PurchasesManager.shared.isPro {
                showPostOnboardingPaywall = true
            }
        }
        .task {
            await session.bootstrap()
            // TESTING ONLY — while onboarding is skipped, sign in with the dev
            // account so authenticated endpoints (places, home) return data.
            if skipOnboardingForTesting && !session.isAuthenticated {
                try? await session.signIn(email: "maptest-0805@example.com", password: "Test1234!")
            }
            // `-showPaywall` launch argument opens the paywall on launch for
            // testing while onboarding is skipped.
            if ProcessInfo.processInfo.arguments.contains("-showPaywall") {
                showPostOnboardingPaywall = true
            }
        }
    }
}
