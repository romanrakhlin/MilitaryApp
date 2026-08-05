//
//  ZipScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Captures the member's ZIP code (numeric, max 5 digits).
struct ZipScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void
    @FocusState private var focused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            OBTitle(title: "What's your ZIP code?",
                    subtitle: "We'll find military discounts in your immediate area.")
                .padding(.top, 8)

            TextField("", text: $onboarding.profile.zip,
                      prompt: Text("ZIP code").foregroundColor(Valor.textTertiary))
                .keyboardType(.numberPad)
                .focused($focused)
                .font(.valorHeadline(20))
                .foregroundStyle(Valor.textPrimary)
                .padding(20)
                .background(RoundedRectangle(cornerRadius: 16).fill(Valor.card.opacity(0.6)))
                .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Valor.cardStroke))
                .submitLabel(.done)
                .onChange(of: onboarding.profile.zip) { new in
                    onboarding.profile.zip = String(new.prefix(5).filter(\.isNumber))
                }
            Spacer()
        }
        .obPadding().padding(.top, 24)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Continue", enabled: onboarding.profile.zip.count >= 5) {
                focused = false
                onNext()
            }
            .onboardingBottomBar()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focused = false }.fontWeight(.semibold)
            }
        }
        .onAppear { focused = true }
    }
}
