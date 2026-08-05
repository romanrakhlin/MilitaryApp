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

    @State private var setupKind: TrackedBenefitKind?
    @State private var perkCategory: InfoBenefitCategory?
    @State private var showCalculator = false
    @State private var showPro = false
    @State private var showDeleteConfirm = false
    @State private var scrollOffset: CGFloat = 0

    private static let privacyPolicyURL = "https://military-app.up.railway.app/privacy"

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
    /// Content has started sliding under the status bar → show the white cap.
    private var isScrolled: Bool { scrollOffset < -12 }
    /// The large greeting is gone → show the compact title.
    private var isCollapsed: Bool { scrollOffset < -56 }

    var body: some View {
        NavigationStack {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        header
                        BenefitTotalCard(totalCents: store.totalCents, benefitCount: store.entries.count)
                        trackableSection
                        perksSection.id("perks")
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
                .onAppear {
                    // `-scrollToPerks` launch argument jumps to the perks grid
                    // for automated screenshots.
                    if ProcessInfo.processInfo.arguments.contains("-scrollToPerks") {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            proxy.scrollTo("perks", anchor: .top)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showPro) { ProUpgradeSheet() }
        .confirmationDialog("Delete your account?", isPresented: $showDeleteConfirm, titleVisibility: .visible) {
            Button("Delete Account", role: .destructive) {
                Task { await session.deleteAccount() }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This permanently deletes your account and all tracked data. This can't be undone.")
        }
        .sheet(item: $setupKind) { kind in setupSheet(kind) }
        .fullScreenCover(item: $perkCategory) { category in
            PerkCategoryCover(category: category,
                              benefits: store.infoBenefits(in: category))
        }
        .sheet(isPresented: $showCalculator) { RatingCalculatorSheet(store: store) }
        .onAppear {
            store.load()
            // `-openStatePerks` launch argument boots straight into the State
            // Benefits browser for automated screenshots.
            if ProcessInfo.processInfo.arguments.contains("-openStatePerks") {
                perkCategory = .state
            }
        }
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
            settingsMenu {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(Valor.textPrimary)
            }
        }
        .padding(.top, 40)
    }

    /// The system settings menu, anchored to whichever button presents it.
    private func settingsMenu<Anchor: View>(@ViewBuilder label: () -> Anchor) -> some View {
        Menu {
            Button { showPro = true } label: {
                Label("Upgrade to Pro", systemImage: "crown.fill")
            }
            Menu {
                Button(role: .destructive) { showDeleteConfirm = true } label: {
                    Label("Delete Account", systemImage: "trash")
                }
            } label: {
                Label("Account", systemImage: "person.crop.circle")
            }
            if let url = URL(string: Self.privacyPolicyURL) {
                Link(destination: url) {
                    Label("Privacy Policy", systemImage: "hand.raised.fill")
                }
            }
        } label: { label() }
    }

    private var compactBar: some View {
        HStack {
            Text(title)
                .font(.valorFont(17, weight: .bold)).foregroundStyle(Valor.textPrimary)
            Spacer()
            settingsMenu {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 17))
                    .foregroundStyle(Valor.textPrimary)
            }
        }
        .padding(.horizontal, 20).padding(.vertical, 12)
        .opacity(isCollapsed ? 1 : 0)
        .allowsHitTesting(isCollapsed)
        .background {
            // Solid white cap over the status-bar area, on as soon as content
            // scrolls underneath — before the compact title itself appears.
            Rectangle().fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 10, y: 3)
                .ignoresSafeArea(edges: .top)
                .opacity(isScrolled ? 1 : 0)
        }
        .animation(.easeInOut(duration: 0.18), value: isCollapsed)
        .animation(.easeInOut(duration: 0.15), value: isScrolled)
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
            LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)],
                      spacing: 12) {
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
