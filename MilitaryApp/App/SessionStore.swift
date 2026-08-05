//
//  SessionStore.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import Combine

/// App-wide session state shared across features via `@EnvironmentObject`.
///
/// Owns the authenticated user's profile, the persisted onboarding-completion
/// flag, and the session-lifecycle actions that change the app's root route
/// (bootstrap, sign in / sign up, logout). It does **not** own the onboarding
/// draft — that lives in `OnboardingStore`.
@MainActor
final class SessionStore: ObservableObject {

    @Published var hasCompletedOnboarding: Bool {
        didSet { UserDefaults.standard.set(hasCompletedOnboarding, forKey: Self.onboardKey) }
    }
    @Published private(set) var isAuthenticated = false
    @Published var profile = UserProfile()

    private let restoreSession: RestoreSessionUseCase
    private let login: LoginUseCase
    private let register: RegisterUseCase
    private let loadProfile: LoadProfileUseCase
    private let updateProfile: UpdateProfileUseCase
    private let completeOnboardingUseCase: CompleteOnboardingUseCase
    private let logoutUseCase: LogoutUseCase

    private static let onboardKey = "valor.hasCompletedOnboarding"

    init(restoreSession: RestoreSessionUseCase,
         login: LoginUseCase,
         register: RegisterUseCase,
         loadProfile: LoadProfileUseCase,
         updateProfile: UpdateProfileUseCase,
         completeOnboarding: CompleteOnboardingUseCase,
         logout: LogoutUseCase) {
        self.restoreSession = restoreSession
        self.login = login
        self.register = register
        self.loadProfile = loadProfile
        self.updateProfile = updateProfile
        self.completeOnboardingUseCase = completeOnboarding
        self.logoutUseCase = logout
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: Self.onboardKey)
    }

    // MARK: - Lifecycle

    /// Called once at launch: if a session token is held, restore the account.
    func bootstrap() async {
        guard let account = try? await restoreSession() else { return }
        apply(account)
        if account.onboardingComplete { hasCompletedOnboarding = true }
    }

    /// Existing user signing in at the end of onboarding.
    func signIn(email: String, password: String) async throws {
        let account = try await login(email: email, password: password)
        apply(account)
        if let fresh = try? await loadProfile() { apply(fresh) }
        completeOnboarding()
    }

    /// New user: create the account, persist the captured onboarding draft,
    /// mark onboarding complete, then enter the app.
    func signUp(email: String, password: String, name: String?, draft: UserProfile) async throws {
        let account = try await register(email: email, password: password, name: name)
        apply(account)

        var toSave = draft
        if let name = name?.trimmingCharacters(in: .whitespaces), !name.isEmpty {
            toSave.name = name
        }
        if let saved = try? await updateProfile(toSave) { apply(saved) }
        else { profile = toSave }

        try? await completeOnboardingUseCase()   // best-effort, like the original flow
        completeOnboarding()
    }

    func logout() {
        logoutUseCase()
        isAuthenticated = false
        profile = UserProfile()
    }

    // MARK: - Onboarding completion

    func completeOnboarding() {
        withAnimation(.easeInOut) { hasCompletedOnboarding = true }
    }

    func resetOnboarding() {
        profile = UserProfile()
        withAnimation(.easeInOut) { hasCompletedOnboarding = false }
    }

    // MARK: - Helpers

    private func apply(_ account: Account) {
        isAuthenticated = true
        profile = account.profile
    }
}
