//
//  OnboardingCoordinatorView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Drives the onboarding flow: owns the `OnboardingStore`, injects it into the
/// subtree, renders the back + progress chrome, and routes the current step to
/// its screen with a directional slide transition.
struct OnboardingCoordinatorView: View {
    @EnvironmentObject private var session: SessionStore
    @StateObject private var onboarding: OnboardingStore

    init(container: AppContainer) {
        _onboarding = StateObject(wrappedValue: container.makeOnboardingStore())
    }

    var body: some View {
        ZStack {
            ValorBackground()

            VStack(spacing: 0) {
                if onboarding.showsChrome {
                    OnboardingHeader(progress: onboarding.progress,
                                     showBack: onboarding.canGoBack,
                                     onBack: onboarding.back)
                        .padding(.bottom, 8)
                }

                stepContent
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.asymmetric(
                        insertion: .move(edge: onboarding.goingForward ? .trailing : .leading)
                            .combined(with: .opacity),
                        removal: .move(edge: onboarding.goingForward ? .leading : .trailing)
                            .combined(with: .opacity)
                    ))
                    .id(onboarding.current)
            }
            // Freeze all input (buttons, options, back) while a step slides in,
            // so nothing can be tapped until the transition fully finishes.
            .allowsHitTesting(!onboarding.isTransitioning)
        }
        .environmentObject(onboarding)
    }

    // MARK: - Routing

    @ViewBuilder
    private var stepContent: some View {
        switch onboarding.current {
        case .welcome:
            WelcomeScreen(onStart: onboarding.next)
        case .socialProof:      SocialProofScreen(onNext: onboarding.next)
        case .describe:         DescribeScreen(onNext: onboarding.next)
        case .goal:             GoalScreen(onNext: onboarding.next)
        case .branch:           BranchScreen(onNext: onboarding.next)
        case .reserveComponent: ReserveComponentScreen(onNext: onboarding.next)
        case .dutyStatus:       DutyStatusScreen(onNext: onboarding.next)
        case .payGrade:         PayGradeScreen(onNext: onboarding.next)
        case .missedStat:       MissedStatScreen(onNext: onboarding.next)
        case .zip:              ZipScreen(onNext: onboarding.next)
        case .discountPreview:  DiscountPreviewScreen(onNext: onboarding.next)
        case .tspKnow:          TSPKnowScreen(onNext: onboarding.next)
        case .qualify:          QualifyScreen(onNext: onboarding.next)
        case .testimonial:      TestimonialScreen(onNext: onboarding.next)
        case .gettingStarted:   InfoScreen.gettingStarted(onNext: onboarding.next)
        case .madeInAmerica:    InfoScreen.madeInAmerica(onNext: onboarding.next)
        case .dataPrivacy:      InfoScreen.dataPrivacy(onNext: finish)
        }
    }

    /// Last step's Continue: hand the captured draft to the session and enter
    /// the app. No account is required to finish onboarding.
    private func finish() {
        session.profile = onboarding.profile
        session.completeOnboarding()
    }
}
