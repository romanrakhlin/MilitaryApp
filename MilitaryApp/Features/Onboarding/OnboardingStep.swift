//
//  OnboardingStep.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The identity of each onboarding screen. The concrete sequence is computed
/// per-profile in `OnboardingStore.steps`.
enum OnboardingStep: Hashable {
    case welcome
    case socialProof
    case describe
    case goal
    case branch
    case reserveComponent
    case dutyStatus
    case payGrade
    case missedStat
    case zip
    case discountPreview
    case tspKnow
    case qualify
    case testimonial
    case gettingStarted
    case madeInAmerica
    case dataPrivacy
}
