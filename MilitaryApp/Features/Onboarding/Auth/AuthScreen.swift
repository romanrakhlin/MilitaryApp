//
//  AuthScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Final onboarding step: create an account or sign in. On success `SessionStore`
/// persists the captured profile (sign-up) or loads the existing one (sign-in),
/// then the app opens.
struct AuthScreen: View {
    @EnvironmentObject private var session: SessionStore
    @EnvironmentObject private var onboarding: OnboardingStore
    @StateObject private var form = AuthStore()
    @FocusState private var focus: Field?

    private enum Field { case name, email, password }

    private var title: String { form.mode == .signUp ? "Create your account" : "Welcome back" }
    private var subtitle: String {
        form.mode == .signUp ? "Save your benefits, discounts, and progress."
                             : "Sign in to pick up right where you left off."
    }
    private var primaryTitle: String { form.mode == .signUp ? "Create account" : "Sign in" }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                VStack(alignment: .leading, spacing: 12) {
                    Text(title).font(.valorTitle(34)).foregroundStyle(Valor.textPrimary)
                    Text(subtitle).font(.valorBody(17)).foregroundStyle(Valor.textSecondary)
                }
                .padding(.top, 8)

                modeToggle

                VStack(spacing: 14) {
                    if form.mode == .signUp {
                        field("Full name", text: $form.name, field: .name,
                              content: .name, keyboard: .default, secure: false)
                    }
                    field("Email", text: $form.email, field: .email,
                          content: .emailAddress, keyboard: .emailAddress, secure: false)
                    field("Password", text: $form.password, field: .password,
                          content: form.mode == .signUp ? .newPassword : .password,
                          keyboard: .default, secure: true)
                }

                if let err = form.errorMessage {
                    Text(err).font(.valorBody(14)).foregroundStyle(Valor.red)
                        .fixedSize(horizontal: false, vertical: true)
                }

                PrimaryButton(title: form.isLoading ? "Please wait…" : primaryTitle,
                              enabled: form.canSubmit && !form.isLoading) {
                    Task { await form.submit(onboarding: onboarding, session: session) }
                }

                dividerOr
                socialButtons

                Text("By continuing you agree to our Terms and Privacy Policy.")
                    .font(.valorBody(12)).foregroundStyle(Valor.textTertiary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 4)

                Color.clear.frame(height: 24)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
        .onAppear {
            form.mode = onboarding.startInSignInMode ? .signIn : .signUp
            if !onboarding.profile.name.isEmpty && onboarding.profile.name != "Roman" {
                form.name = onboarding.profile.name
            }
        }
        .onChange(of: form.mode) { _ in form.errorMessage = nil }
    }

    // MARK: Actions

    private func advanceFocus(from f: Field) {
        switch f {
        case .name: focus = .email
        case .email: focus = .password
        case .password: if form.canSubmit { Task { await form.submit(onboarding: onboarding, session: session) } }
        }
    }

    // MARK: Pieces

    private var modeToggle: some View {
        HStack(spacing: 0) {
            toggleHalf("Create account", active: form.mode == .signUp) {
                Haptics.selection()
                withAnimation(.snappy(duration: 0.25)) { form.mode = .signUp }
            }
            toggleHalf("Sign in", active: form.mode == .signIn) {
                Haptics.selection()
                withAnimation(.snappy(duration: 0.25)) { form.mode = .signIn }
            }
        }
        .padding(4)
        .background(RoundedRectangle(cornerRadius: 14).fill(Valor.card.opacity(0.6)))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
    }

    private func toggleHalf(_ label: String, active: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.valorButton(15))
                .foregroundStyle(active ? .white : Valor.textSecondary)
                .frame(maxWidth: .infinity).padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 11)
                        .fill(active ? AnyShapeStyle(Valor.brandGradient) : AnyShapeStyle(Color.clear))
                )
        }
        .buttonStyle(.plain)
    }

    private func field(_ placeholder: String, text: Binding<String>, field: Field,
                       content: UITextContentType, keyboard: UIKeyboardType, secure: Bool) -> some View {
        Group {
            if secure {
                SecureField("", text: text, prompt: Text(placeholder).foregroundColor(Valor.textTertiary))
            } else {
                TextField("", text: text, prompt: Text(placeholder).foregroundColor(Valor.textTertiary))
            }
        }
        .textContentType(content)
        .keyboardType(keyboard)
        .textInputAutocapitalization(field == .email ? .never : .words)
        .autocorrectionDisabled(field != .name)
        .focused($focus, equals: field)
        .submitLabel(field == .password ? .go : .next)
        .onSubmit { advanceFocus(from: field) }
        .font(.valorBody(17)).foregroundStyle(Valor.textPrimary)
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 14).fill(Valor.card.opacity(0.6)))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
    }

    private var dividerOr: some View {
        HStack(spacing: 12) {
            Rectangle().fill(Valor.cardStroke).frame(height: 1)
            Text("or").font(.valorBody(13)).foregroundStyle(Valor.textTertiary)
            Rectangle().fill(Valor.cardStroke).frame(height: 1)
        }
    }

    private var socialButtons: some View {
        VStack(spacing: 12) {
            socialButton("Continue with Apple", system: "apple.logo", fg: .black, bg: .white)
            socialButton("Continue with Google", system: "g.circle.fill", fg: .white,
                         bg: Valor.card.opacity(0.9))
        }
    }

    private func socialButton(_ title: String, system: String, fg: Color, bg: Color) -> some View {
        Button {
            Haptics.warning()
            form.errorMessage = "Social sign-in is coming soon — use email for now."
        } label: {
            HStack(spacing: 10) {
                Image(systemName: system)
                Text(title).font(.valorButton(16))
            }
            .foregroundStyle(fg)
            .frame(maxWidth: .infinity).padding(.vertical, 15)
            .background(RoundedRectangle(cornerRadius: 14).fill(bg))
            .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
        }
        .buttonStyle(.plain)
    }
}
