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
/// No navigation bar: the greeting title scrolls away with the content, and
/// the settings button stays fixed in the top-right corner.
struct HomeView: View {
    @EnvironmentObject private var session: SessionStore
    @StateObject private var store: HomeStore

    @State private var setupKind: TrackedBenefitKind?
    @State private var perkCategory: InfoBenefitCategory?
    @State private var showCalculator = false
    @State private var showPro = false
    @State private var showDeleteConfirm = false

    private static let privacyPolicyURL = "https://ancient-cinema-d79.notion.site/Privacy-Policy-Valor-3b3df6f28b7380539b20f74883c9b821?pvs=73"

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
                    // Anchored to the content's top-right corner: visible in
                    // its usual spot on open, and scrolls away with the
                    // header. (The gear emoji shows as "?" in beta simulator
                    // runtimes missing the emoji font — it renders correctly
                    // on device.)
                    .overlay(alignment: .topTrailing) {
                        settingsMenu {
                            Text("⚙️").font(.system(size: 24))
                                .frame(width: 40, height: 40)
                                .contentShape(Rectangle())
                        }
                        .padding(.trailing, 16)
                    }
                }
                .scrollIndicators(.hidden)
                .background(ValorBackground().ignoresSafeArea())
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
        .fullScreenCover(isPresented: $showPro) { PaywallScreen() }
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
            if category == .state {
                StateBenefitsCover(federalBenefits: store.federalBenefits,
                                   states: store.stateGuides)
            } else {
                PerkCategoryCover(category: category,
                                  benefits: store.infoBenefits(in: category))
            }
        }
        .sheet(isPresented: $showCalculator) { RatingCalculatorSheet(store: store) }
        .onAppear {
            store.load()
            // `-openStatePerks` launch argument boots straight into the State
            // Benefits browser for automated screenshots.
            if ProcessInfo.processInfo.arguments.contains("-openStatePerks") {
                perkCategory = .state
            } else if ProcessInfo.processInfo.arguments.contains("-openAirlines") {
                perkCategory = .airlines
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
        }
        .padding(.top, 40)
    }

    /// Accent-tinted SF symbol for menu rows: UIMenu repaints template images
    /// black, but an `.alwaysOriginal` pre-tinted image keeps its color.
    private func menuIcon(_ systemName: String) -> Image {
        Image(uiImage: UIImage(systemName: systemName)?
            .withTintColor(UIColor(Valor.blue), renderingMode: .alwaysOriginal) ?? UIImage())
    }

    /// The system settings menu, anchored to whichever button presents it.
    private func settingsMenu<Anchor: View>(@ViewBuilder label: () -> Anchor) -> some View {
        Menu {
            Button { showPro = true } label: {
                Label { Text("Upgrade to Pro") } icon: { menuIcon("crown.fill") }
            }
            Menu {
                Button(role: .destructive) { showDeleteConfirm = true } label: {
                    Label("Delete Account", systemImage: "trash")
                }
            } label: {
                Label { Text("Account") } icon: { menuIcon("person.crop.circle") }
            }
            if let url = URL(string: Self.privacyPolicyURL) {
                Link(destination: url) {
                    Label { Text("Privacy Policy") } icon: { menuIcon("hand.raised.fill") }
                }
            }
        } label: { label() }
        // Plain style so the anchor keeps its own rendering — the default
        // menu style tints the label, which turns emoji into "?" glyphs.
        .buttonStyle(.plain)
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
                                       count: category == .state
                                           ? store.stateGuides.count
                                           : store.infoBenefits(in: category).count) {
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
