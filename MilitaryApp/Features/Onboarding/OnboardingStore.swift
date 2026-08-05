//
//  OnboardingStore.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import Combine

/// Owns the onboarding draft profile and the step navigation. Injected into
/// the onboarding subtree via `@EnvironmentObject` so each screen can read /
/// write the draft. Network persistence happens in `SessionStore` at the auth
/// step — this store is UI/navigation only.
@MainActor
final class OnboardingStore: ObservableObject {
    @Published var profile = UserProfile()
    @Published var index = 0
    /// Drives the slide direction so Back reverses the transition.
    @Published var goingForward = true
    /// Controls the initial mode of the end-of-onboarding auth screen.
    @Published var startInSignInMode = false

    /// Guards against double navigation while a transition is in flight.
    private var navLocked = false

    /// The single navigation animation, reused so forward and back feel identical.
    let navAnimation: Animation = .snappy(duration: 0.42, extraBounce: 0.04)

    /// The step sequence, recomputed from the profile so each status only sees
    /// the questions that apply. Dependents have no branch or pay grade; only
    /// currently-serving members are asked about TSP.
    var steps: [OnboardingStep] {
        let status = profile.status
        let isDependent = status == .dependent
        let isServing = status == .activeDuty || status == .reservesGuard

        var s: [OnboardingStep] = [.welcome, .socialProof, .describe, .goal]

        if !isDependent { s.append(.branch) }
        if status == .reservesGuard { s += [.reserveComponent, .dutyStatus] }
        if !isDependent { s.append(.payGrade) }

        s += [.missedStat, .zip, .discountPreview]

        if isServing { s.append(.tspKnow) }

        s += [.qualify, .testimonial, .gettingStarted, .madeInAmerica, .dataPrivacy, .auth]
        return s
    }

    var current: OnboardingStep { steps[min(index, steps.count - 1)] }

    var progress: Double {
        guard steps.count > 1 else { return 0 }
        return Double(index) / Double(steps.count - 1)
    }

    /// The welcome screen has its own full-bleed layout (no chrome).
    var showsChrome: Bool { current != .welcome }

    var canGoBack: Bool { index > 0 }

    // MARK: - Navigation

    func next() {
        guard !navLocked, index < steps.count - 1 else { return }
        lockNav()
        goingForward = true
        withAnimation(navAnimation) { index += 1 }
    }

    func back() {
        guard !navLocked, index > 0 else { return }
        lockNav()
        goingForward = false
        withAnimation(navAnimation) { index -= 1 }
    }

    /// Skips straight to the auth screen (used by "Already have an account?").
    func jumpToAuth(signIn: Bool) {
        startInSignInMode = signIn
        goingForward = true
        withAnimation(navAnimation) { index = steps.count - 1 }
    }

    /// Briefly blocks further navigation while a transition is in flight so a
    /// second (stale or accidental) advance can't skip a screen.
    private func lockNav() {
        navLocked = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) { [weak self] in
            self?.navLocked = false
        }
    }
}
