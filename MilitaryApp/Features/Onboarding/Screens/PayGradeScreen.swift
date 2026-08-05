//
//  PayGradeScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Captures pay category (segmented) plus grade + years (two wheels).
struct PayGradeScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void

    private var categories: [PayCategory] { PayCategory.available(for: onboarding.profile.branch) }
    private var category: PayCategory {
        let selected = onboarding.profile.payCategory ?? .enlisted
        return categories.contains(selected) ? selected : .enlisted
    }

    private var canContinue: Bool {
        onboarding.profile.payGrade != nil && onboarding.profile.yearsServed != nil
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OBTitle(title: "What's your pay grade?",
                    subtitle: "This tailors the benefits and pay estimates we show you.")
                .padding(.top, 8)

            // Category — a native segmented control.
            Picker("Pay category", selection: Binding(
                get: { category },
                set: { newCat in
                    Haptics.selection()
                    onboarding.profile.payCategory = newCat
                    onboarding.profile.payGrade = nil          // grade is category-specific
                }
            )) {
                ForEach(categories) { Text($0.rawValue).tag($0) }
            }
            .pickerStyle(.segmented)

            // Grade + years — two spinning wheels, like a date picker.
            HStack(spacing: 0) {
                wheelColumn(title: "Grade") {
                    Picker("Grade", selection: $onboarding.profile.payGrade) {
                        Text("—").tag(String?.none)
                        ForEach(category.grades, id: \.self) { g in
                            Text(g).tag(String?.some(g))
                        }
                    }
                    .pickerStyle(.wheel)
                }
                wheelColumn(title: "Years served") {
                    Picker("Years served", selection: $onboarding.profile.yearsServed) {
                        Text("—").tag(Int?.none)
                        ForEach(1...30, id: \.self) { yr in
                            Text(yr == 30 ? "30+" : "\(yr)").tag(Int?.some(yr))
                        }
                    }
                    .pickerStyle(.wheel)
                }
            }
            .frame(height: 190)
            .padding(.vertical, 6)
            .background(RoundedRectangle(cornerRadius: 20, style: .continuous).fill(Valor.card.opacity(0.5)))
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).strokeBorder(Valor.cardStroke))

            Spacer()
        }
        .obPadding().padding(.top, 24)
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Continue", enabled: canContinue, action: onNext)
                .onboardingBottomBar()
        }
    }

    private func wheelColumn<Content: View>(title: String,
                                            @ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.valorFont(13, weight: .semibold))
                .foregroundStyle(Valor.textSecondary)
            content()
        }
        .frame(maxWidth: .infinity)
    }
}
