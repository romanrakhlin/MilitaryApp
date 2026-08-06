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

    /// Pins for the discount-preview map, loaded once a location fix exists.
    @Published private(set) var nearbyPlaces: [Place] = []

    private let loadPlaces: LoadPlacesUseCase

    init(loadPlaces: LoadPlacesUseCase) {
        self.loadPlaces = loadPlaces
    }

    /// True while a step transition is animating. The coordinator disables all
    /// hit-testing during this window, so nothing can be tapped (and no stray
    /// haptics fire) until the slide fully settles. Also guards next()/back()
    /// against double navigation.
    @Published private(set) var isTransitioning = false

    /// The single navigation animation, reused so forward and back feel identical.
    let navAnimation: Animation = .snappy(duration: 0.42, extraBounce: 0.04)

    /// The step sequence, recomputed from the profile so each status only sees
    /// the questions that apply. Dependents have no branch or pay grade; only
    /// currently-serving members are asked about TSP.
    var steps: [OnboardingStep] {
        let status = profile.status
        let isDependent = status == .dependent
        let isServing = status == .activeDuty || status == .reservesGuard

        var s: [OnboardingStep] = [.welcome, .describe, .goal]

        if !isDependent { s.append(.branch) }
        if status == .reservesGuard { s += [.reserveComponent, .dutyStatus] }
        if !isDependent { s.append(.payGrade) }

        s += [.missedStat, .zip, .discountPreview]

        if isServing { s.append(.tspKnow) }

        s += [.qualify, .testimonial, .gettingStarted, .madeInAmerica, .dataPrivacy]
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

    // MARK: - Nearby places

    /// Best-effort fetch for the discount-preview map. Onboarding runs before
    /// any sign-in, so a failure (e.g. the backend requiring auth) just leaves
    /// the map pin-free — the preview still centers on the user.
    @MainActor
    func loadNearbyPlaces(lat: Double, lng: Double) async {
        guard nearbyPlaces.isEmpty else { return }
        // The anonymous device sign-in races this fetch on a cold launch, so
        // briefly retry instead of giving up on the first 401.
        for attempt in 0..<3 {
            if attempt > 0 { try? await Task.sleep(for: .seconds(2)) }
            guard !Task.isCancelled else { return }
            if let places = try? await loadPlaces(lat: lat, lng: lng, radiusMiles: 10), !places.isEmpty {
                nearbyPlaces = Array(places.prefix(30))
                return
            }
        }
    }

    // MARK: - Navigation

    func next() {
        guard !isTransitioning, index < steps.count - 1 else { return }
        beginTransition()
        goingForward = true
        withAnimation(navAnimation) { index += 1 }
    }

    func back() {
        guard !isTransitioning, index > 0 else { return }
        beginTransition()
        goingForward = false
        withAnimation(navAnimation) {
            index -= 1
            clearAnswer(for: steps[index])
        }
    }

    /// Returning to a single-choice screen shows it fresh: the previously
    /// picked option is cleared so nothing appears pre-selected.
    private func clearAnswer(for step: OnboardingStep) {
        switch step {
        case .describe:         profile.status = nil
        case .goal:             profile.goal = nil
        case .branch:           profile.branch = nil
        case .reserveComponent: profile.reserveComponent = nil
        case .dutyStatus:       profile.dutyStatus = nil
        case .tspKnow:          profile.knowsTSP = nil
        default: break   // multi-field screens (pay grade, ZIP) keep their values
        }
    }

    /// Opens the "transition in flight" window: navigation is ignored and the
    /// coordinator blocks all touches until the slide animation has settled.
    private func beginTransition() {
        isTransitioning = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isTransitioning = false
        }
    }
}
