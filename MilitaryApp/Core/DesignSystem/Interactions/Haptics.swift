//
//  Haptics.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import UIKit

/// Shared tactile feedback helpers used across onboarding and the app.
enum Haptics {
    /// Light tick for selecting an option / chip.
    static func selection() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
    /// Impact for a primary tap / advancing a step.
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
    /// Celebration for finishing onboarding / creating an account.
    static func success() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    static func warning() {
        UINotificationFeedbackGenerator().notificationOccurred(.warning)
    }
}
