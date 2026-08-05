//
//  HomeView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The benefits dashboard: headline tracked total, the configurable benefits
/// that feed it, informational perks with links out, and calculator tools.
struct HomeView: View {
    @EnvironmentObject private var session: SessionStore
    @StateObject private var store: HomeStore

    @State private var showSettings = false
    @State private var setupKind: TrackedBenefitKind?
    @State private var infoBenefit: InfoBenefit?
    @State private var showCalculator = false

    init(container: AppContainer) {
        _store = StateObject(wrappedValue: container.makeHomeStore())
    }

    private var greeting: String {
        let h = Calendar.current.component(.hour, from: Date())
        switch h {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HomeHeader(title: "\(greeting), \(session.profile.name)") { showSettings = true }
                    BenefitTotalCard(totalCents: store.totalCents, benefitCount: store.entries.count)
                    trackableSection
                    perksSection
                    toolsSection
                    Color.clear.frame(height: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .background(ValorBackground().ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Benefits")
                        .font(.valorFont(20, weight: .black))
                        .foregroundStyle(Valor.textPrimary)
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .sheet(isPresented: $showSettings) { SettingsView() }
        .sheet(item: $setupKind) { kind in setupSheet(kind) }
        .sheet(item: $infoBenefit) { InfoBenefitDetailSheet(benefit: $0) }
        .sheet(isPresented: $showCalculator) { RatingCalculatorSheet(store: store) }
        .onAppear { store.load() }
    }

    // MARK: Section 1 — trackable benefits

    private var trackableSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HomeSectionHeader(title: "Your Benefits",
                              subtitle: "Set each one up to add it to your tracked total")
            ForEach(TrackedBenefitKind.allCases) { kind in
                TrackableBenefitRow(kind: kind, entry: store.entry(for: kind)) {
                    setupKind = kind
                }
            }
        }
    }

    // MARK: Section 2 — informational perks

    private var perksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HomeSectionHeader(title: "Perks & Discounts",
                              subtitle: "Tap a brand to see the benefit and go to its official page")
            ForEach(InfoBenefitCategory.allCases) { category in
                Text(category.rawValue.uppercased())
                    .font(.valorFont(12, weight: .heavy))
                    .foregroundStyle(Valor.textTertiary).tracking(1)
                    .padding(.top, 4)
                ForEach(store.infoBenefits(in: category)) { benefit in
                    InfoBenefitRow(benefit: benefit) { infoBenefit = benefit }
                }
            }
        }
    }

    // MARK: Section 3 — tools

    private var toolsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HomeSectionHeader(title: "Tools",
                              subtitle: "Play with the numbers behind your benefits")
            ToolRow(icon: "percent",
                    title: "Disability Rating Calculator",
                    subtitle: store.savedRatings.isEmpty
                        ? "Combine ratings with VA math"
                        : "\(store.savedRatings.count) saved calculation\(store.savedRatings.count == 1 ? "" : "s")",
                    tint: Valor.blue) {
                showCalculator = true
            }
        }
    }

    // MARK: Setup sheet routing

    @ViewBuilder
    private func setupSheet(_ kind: TrackedBenefitKind) -> some View {
        switch kind {
        case .creditCards: CreditCardPickerSheet(store: store)
        case .vaDisability: DisabilitySetupSheet(store: store)
        case .tspMatch: TSPMatchSheet(store: store)
        case .commissary: CommissarySheet(store: store)
        }
    }
}
