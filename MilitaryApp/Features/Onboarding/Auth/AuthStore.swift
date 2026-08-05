//
//  AuthStore.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import Combine

/// Form state + submission for the end-of-onboarding auth screen. Delegates the
/// actual network work to `SessionStore` (which owns the route-changing auth
/// flow) and surfaces loading / error state to the view.
@MainActor
final class AuthStore: ObservableObject {
    enum Mode { case signUp, signIn }

    @Published var mode: Mode = .signUp
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    var canSubmit: Bool {
        email.contains("@") && password.count >= 6 &&
        (mode == .signIn || !name.trimmingCharacters(in: .whitespaces).isEmpty)
    }

    func submit(onboarding: OnboardingStore, session: SessionStore) async {
        dismissKeyboard()
        errorMessage = nil
        isLoading = true
        defer { isLoading = false }

        do {
            switch mode {
            case .signUp:
                let clean = name.trimmingCharacters(in: .whitespaces)
                if !clean.isEmpty { onboarding.profile.name = clean }
                try await session.signUp(email: email.lowercased(), password: password,
                                         name: clean, draft: onboarding.profile)
                Haptics.success()
            case .signIn:
                try await session.signIn(email: email.lowercased(), password: password)
                Haptics.success()
            }
        } catch {
            errorMessage = error.localizedDescription
            Haptics.warning()
        }
    }
}
