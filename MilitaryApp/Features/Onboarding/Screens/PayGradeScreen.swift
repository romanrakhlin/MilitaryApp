//
//  PayGradeScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Captures pay category, exact grade, and years served as a progressive
/// accordion: each answer reveals the next section, and answered sections
/// collapse to a summary row that can be reopened with its chevron.
struct PayGradeScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    let onNext: () -> Void

    /// Which accordion section is currently open (one at a time).
    private enum Section { case type, grade, years }
    @State private var open: Section? = .type

    private let typeCols = Array(repeating: GridItem(.flexible(), spacing: 10), count: 3)
    private let gradeCols = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)

    private var categories: [PayCategory] { PayCategory.available(for: onboarding.profile.branch) }

    /// The chosen category, but only if it's valid for the current branch.
    private var category: PayCategory? {
        guard let c = onboarding.profile.payCategory, categories.contains(c) else { return nil }
        return c
    }

    private var canContinue: Bool {
        onboarding.profile.payGrade != nil && onboarding.profile.yearsServed != nil
    }

    private var yearsBinding: Binding<Double> {
        Binding(
            get: { Double(onboarding.profile.yearsServed ?? 0) },
            set: { onboarding.profile.yearsServed = Int($0.rounded()) }
        )
    }

    private var yearsLabel: String {
        guard let y = onboarding.profile.yearsServed else { return "Drag to set" }
        if y <= 0 { return "Less than 1 year" }
        if y >= 30 { return "30+ years" }
        return y == 1 ? "1 year" : "\(y) years"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                OBTitle(title: "What's your pay grade?",
                        subtitle: "This tailors the benefits and pay estimates we show you.")
                    .padding(.top, 8).padding(.bottom, 6)

                typeSection
                if category != nil {
                    gradeSection.transition(sectionTransition)
                }
                if onboarding.profile.payGrade != nil {
                    yearsSection.transition(sectionTransition)
                }
                Color.clear.frame(height: 40)
            }
            .obPadding().padding(.top, 12)
        }
        .safeAreaInset(edge: .bottom) {
            PrimaryButton(title: "Continue", enabled: canContinue, action: onNext)
                .onboardingBottomBar()
        }
    }

    private var sectionTransition: AnyTransition {
        .move(edge: .top).combined(with: .opacity)
    }

    // MARK: Sections

    private var typeSection: some View {
        sectionCard {
            header(.type, title: "Type", value: category?.rawValue)
            if open == .type {
                LazyVGrid(columns: typeCols, spacing: 10) {
                    ForEach(categories) { c in
                        ChipButton(title: c.rawValue, selected: category == c) {
                            withAnimation(.snappy(duration: 0.3)) {
                                onboarding.profile.payCategory = c
                                onboarding.profile.payGrade = nil   // grade is category-specific
                                open = .grade
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom], 14)
            }
        }
    }

    private var gradeSection: some View {
        sectionCard {
            header(.grade, title: "Grade", value: onboarding.profile.payGrade)
            if open == .grade {
                LazyVGrid(columns: gradeCols, spacing: 10) {
                    ForEach(category?.grades ?? [], id: \.self) { g in
                        ChipButton(title: g, selected: onboarding.profile.payGrade == g) {
                            withAnimation(.snappy(duration: 0.3)) {
                                onboarding.profile.payGrade = g
                                open = .years
                            }
                        }
                    }
                }
                .padding([.horizontal, .bottom], 14)
            }
        }
    }

    private var yearsSection: some View {
        sectionCard {
            header(.years, title: "Years of service",
                   value: onboarding.profile.yearsServed == nil ? nil : yearsLabel)
            if open == .years {
                VStack(alignment: .leading, spacing: 10) {
                    Text(yearsLabel)
                        .font(.valorButton(18))
                        .foregroundStyle(onboarding.profile.yearsServed == nil
                                         ? Valor.textTertiary : Valor.blue)
                    Slider(value: yearsBinding, in: 0...30, step: 1) { editing in
                        if editing { Haptics.selection() }
                    }
                    .tint(Valor.blue)
                }
                .padding([.horizontal, .bottom], 16)
            }
        }
    }

    // MARK: Building blocks

    private func header(_ section: Section, title: String, value: String?) -> some View {
        Button {
            Haptics.impact(.light)
            withAnimation(.snappy(duration: 0.3)) {
                open = (open == section) ? nil : section
            }
        } label: {
            HStack(spacing: 10) {
                Text(title).font(.valorButton(17)).foregroundStyle(Valor.textPrimary)
                Spacer()
                if let value {
                    Text(value).font(.valorButton(16)).foregroundStyle(Valor.blue)
                }
                Image(systemName: "chevron.down")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Valor.textTertiary)
                    .rotationEffect(.degrees(open == section ? 0 : -90))
            }
            .padding(16)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private func sectionCard<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 0) { content() }
            .background(RoundedRectangle(cornerRadius: 18, style: .continuous).fill(Valor.card.opacity(0.5)))
            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 18, style: .continuous).strokeBorder(Valor.cardStroke))
    }
}
