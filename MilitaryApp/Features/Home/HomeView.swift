//
//  HomeView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The benefits dashboard: headline tracked total, the configurable benefits
/// that feed it, informational perks with links out, and calculator tools.
///
/// The greeting is the screen's title. The system nav bar stays hidden (in a
/// TabView the collapsed system title falls back to the tab name — "Home");
/// instead a compact bar with the greeting fades in once the header scrolls
/// away.
struct HomeView: View {
    @EnvironmentObject private var session: SessionStore
    @StateObject private var store: HomeStore

    @State private var showSettings = false
    @State private var setupKind: TrackedBenefitKind?
    @State private var perkCategory: InfoBenefitCategory?
    @State private var showCalculator = false
    @State private var scrollOffset: CGFloat = 0

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

    /// First name only so the title stays on one line.
    private var firstName: String {
        session.profile.name.components(separatedBy: " ").first ?? session.profile.name
    }

    private var title: String { "\(greeting), \(firstName)" }
    private var isCollapsed: Bool { scrollOffset < -56 }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header
                    BenefitTotalCard(totalCents: store.totalCents, benefitCount: store.entries.count)
                    trackableSection
                    perksSection
                    toolsSection
                    Color.clear.frame(height: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .background(
                    GeometryReader { geo in
                        Color.clear.preference(key: HomeScrollOffsetKey.self,
                                               value: geo.frame(in: .named("homeScroll")).minY)
                    }
                )
            }
            .coordinateSpace(name: "homeScroll")
            .onPreferenceChange(HomeScrollOffsetKey.self) { scrollOffset = $0 }
            .scrollIndicators(.hidden)
            .background(ValorBackground().ignoresSafeArea())
            .overlay(alignment: .top) { compactBar }
            .toolbar(.hidden, for: .navigationBar)
        }
        .sheet(isPresented: $showSettings) { SettingsView() }
        .sheet(item: $setupKind) { kind in setupSheet(kind) }
        .fullScreenCover(item: $perkCategory) { category in
            PerkCategoryCover(category: category,
                              benefits: store.infoBenefits(in: category))
        }
        .sheet(isPresented: $showCalculator) { RatingCalculatorSheet(store: store) }
        .onAppear { store.load() }
    }

    // MARK: Header + compact title bar

    private var header: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.valorTitle(32)).foregroundStyle(Valor.textPrimary)
                    .minimumScaleFactor(0.7).lineLimit(1)
                Text("Track and Maximize Your Benefits")
                    .font(.valorBody(15)).foregroundStyle(Valor.textSecondary)
            }
            Spacer()
            Button { showSettings = true } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Valor.blue)
                    .frame(width: 32, height: 32)
                    .background(Circle().fill(Valor.blue.opacity(0.10)))
            }
        }
        .padding(.top, 6)
    }

    private var compactBar: some View {
        HStack {
            Text(title)
                .font(.valorFont(17, weight: .bold)).foregroundStyle(Valor.textPrimary)
            Spacer()
            Button { showSettings = true } label: {
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Valor.blue)
            }
        }
        .padding(.horizontal, 20).padding(.vertical, 12)
        .background {
            Rectangle().fill(.ultraThinMaterial).ignoresSafeArea(edges: .top)
        }
        .opacity(isCollapsed ? 1 : 0)
        .animation(.easeInOut(duration: 0.18), value: isCollapsed)
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
                              subtitle: "Browse military benefits by category")
            HStack(spacing: 12) {
                ForEach(InfoBenefitCategory.allCases) { category in
                    PerkCategoryButton(category: category,
                                       count: store.infoBenefits(in: category).count) {
                        perkCategory = category
                    }
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
