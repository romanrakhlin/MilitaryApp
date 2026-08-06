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
    @Published var profile = UserProfile() {
        didSet { Self.persist(profile) }
    }

    private let restoreSession: RestoreSessionUseCase
    private let deviceLogin: DeviceLoginUseCase
    private let login: LoginUseCase
    private let register: RegisterUseCase
    private let loadProfile: LoadProfileUseCase
    private let updateProfile: UpdateProfileUseCase
    private let completeOnboardingUseCase: CompleteOnboardingUseCase
    private let logoutUseCase: LogoutUseCase
    private let deleteAccountUseCase: DeleteAccountUseCase
    private let clearLocalBenefits: ClearLocalBenefitsUseCase
    private let seedTrackedBenefits: SeedTrackedBenefitsUseCase

    private static let onboardKey = "valor.hasCompletedOnboarding"
    private static let profileKey = "valor.profile"
    private static let deviceIDKey = "valor.deviceID"

    init(restoreSession: RestoreSessionUseCase,
         deviceLogin: DeviceLoginUseCase,
         login: LoginUseCase,
         register: RegisterUseCase,
         loadProfile: LoadProfileUseCase,
         updateProfile: UpdateProfileUseCase,
         completeOnboarding: CompleteOnboardingUseCase,
         logout: LogoutUseCase,
         deleteAccount: DeleteAccountUseCase,
         clearLocalBenefits: ClearLocalBenefitsUseCase,
         seedTrackedBenefits: SeedTrackedBenefitsUseCase) {
        self.restoreSession = restoreSession
        self.deviceLogin = deviceLogin
        self.login = login
        self.register = register
        self.loadProfile = loadProfile
        self.updateProfile = updateProfile
        self.completeOnboardingUseCase = completeOnboarding
        self.logoutUseCase = logout
        self.deleteAccountUseCase = deleteAccount
        self.clearLocalBenefits = clearLocalBenefits
        self.seedTrackedBenefits = seedTrackedBenefits
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: Self.onboardKey)
        if let saved = Self.loadPersistedProfile() { self.profile = saved }
    }

    // MARK: - Lifecycle

    /// Called once at launch: restore the held session, or fall back to an
    /// anonymous device-scoped sign-in so authenticated endpoints (places,
    /// profile) work from the very first launch.
    func bootstrap() async {
        if let account = try? await restoreSession() {
            apply(account)
            if account.onboardingComplete { hasCompletedOnboarding = true }
            return
        }
        if let account = try? await deviceLogin(deviceId: Self.deviceID()) {
            // Keep any locally captured answers: the fresh anonymous account's
            // empty profile must not clobber a finished onboarding draft.
            isAuthenticated = true
            if !hasCompletedOnboarding { profile = account.profile }
        }
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

    /// Deletes the account on the backend, then wipes everything local —
    /// tracked benefits, session, profile — and returns to onboarding.
    func deleteAccount() async {
        try? await deleteAccountUseCase()   // local wipe proceeds even if the server call fails
        clearLocalBenefits()
        logout()
        resetOnboarding()
    }

    // MARK: - Onboarding completion

    /// Last onboarding step: adopt the captured draft, push it to the backend
    /// (best-effort — the device session normally exists by now), and enter
    /// the app.
    func finishOnboarding(draft: UserProfile) async {
        profile = draft
        seedTrackedBenefits(profile: draft)
        if isAuthenticated {
            if let saved = try? await updateProfile(draft) { apply(saved) }
            try? await completeOnboardingUseCase()
        }
        completeOnboarding()
    }

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

    /// Stable per-install identifier for the anonymous device session,
    /// generated on first launch. A reinstall gets a fresh ID (and thus a
    /// fresh anonymous account).
    private static func deviceID() -> String {
        if let existing = UserDefaults.standard.string(forKey: deviceIDKey) { return existing }
        let fresh = UUID().uuidString
        UserDefaults.standard.set(fresh, forKey: deviceIDKey)
        return fresh
    }

    // MARK: - Profile persistence

    /// The profile is captured during onboarding but no account is required to
    /// finish it, so the snapshot lives in `UserDefaults` — mirroring the
    /// onboarding-complete flag — and survives relaunches until a server
    /// profile replaces it.
    private static func persist(_ profile: UserProfile) {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: profileKey)
        }
    }

    private static func loadPersistedProfile() -> UserProfile? {
        guard let data = UserDefaults.standard.data(forKey: profileKey) else { return nil }
        return try? JSONDecoder().decode(UserProfile.self, from: data)
    }
}
