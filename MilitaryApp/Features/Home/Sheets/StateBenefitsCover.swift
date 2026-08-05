//
//  StateBenefitsCover.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Fullscreen State Benefits directory: a search bar, a standalone federal
/// (all-states) cell, and every state — each opening its own benefits list.
struct StateBenefitsCover: View {
    let federalBenefits: [StateBenefit]
    let states: [StateGuide]
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @FocusState private var searchFocused: Bool
    /// Programmatic push target for the `-openStateDetail` screenshot arg.
    @State private var devState: StateGuide?

    private var filteredStates: [StateGuide] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return states }
        return states.filter {
            $0.name.localizedCaseInsensitiveContains(query)
                || $0.abbreviation.localizedCaseInsensitiveContains(query)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        header
                        searchBar

                        if searchText.isEmpty {
                            federalCell
                        }

                        if filteredStates.isEmpty {
                            emptyState
                        } else {
                            Text(searchText.isEmpty ? "By State" : "Results")
                                .font(.valorFont(13, weight: .bold))
                                .foregroundStyle(Valor.textTertiary)
                                .textCase(.uppercase)
                                .padding(.top, 6)
                            ForEach(filteredStates) { state in
                                stateRow(state)
                            }
                        }
                        Color.clear.frame(height: 24)
                    }
                    .padding(20)
                }
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.interactively)
            }
            .navigationDestination(item: $devState) { state in
                StateBenefitListScreen(title: state.name,
                                       subtitle: "\(state.benefits.count) state benefits",
                                       benefits: state.benefits)
            }
            .onAppear {
                // `-openStateDetail` launch argument pushes Texas for
                // automated screenshots.
                if ProcessInfo.processInfo.arguments.contains("-openStateDetail") {
                    devState = states.first { $0.abbreviation == "TX" }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(Valor.textSecondary)
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }

    private var header: some View {
        HStack(spacing: 14) {
            Image(systemName: "building.columns.fill")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(Valor.green)
                .frame(width: 52, height: 52)
                .background(Circle().fill(Valor.green.opacity(0.13)))
            VStack(alignment: .leading, spacing: 2) {
                Text("State Benefits")
                    .font(.valorTitle(28)).foregroundStyle(Valor.textPrimary)
                Text("Federal plus all \(states.count) states")
                    .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
            }
        }
        .padding(.bottom, 6)
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Valor.textSecondary)
            TextField("Search states", text: $searchText)
                .font(.valorBody(16))
                .foregroundStyle(Valor.textPrimary)
                .focused($searchFocused)
                .submitLabel(.search)
                .autocorrectionDisabled()
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(Valor.textTertiary)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 14).fill(Color.white))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
    }

    /// Standalone cell for the benefits every state shares.
    private var federalCell: some View {
        NavigationLink {
            StateBenefitListScreen(title: "Federal Benefits",
                                   subtitle: "Available in all states",
                                   benefits: federalBenefits)
        } label: {
            HStack(spacing: 14) {
                Image(systemName: "flag.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Valor.blue)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Valor.blue.opacity(0.13)))
                VStack(alignment: .leading, spacing: 2) {
                    Text("Federal Benefits")
                        .font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                    Text("All states • \(federalBenefits.count) programs")
                        .font(.valorBody(13)).foregroundStyle(Valor.textSecondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Valor.textTertiary)
            }
            .padding(14)
            .homeCardSurface()
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private func stateRow(_ state: StateGuide) -> some View {
        NavigationLink {
            StateBenefitListScreen(title: state.name,
                                   subtitle: "\(state.benefits.count) state benefits",
                                   benefits: state.benefits)
        } label: {
            HStack(spacing: 14) {
                Text(state.abbreviation)
                    .font(.valorFont(14, weight: .bold))
                    .foregroundStyle(Valor.green)
                    .frame(width: 44, height: 44)
                    .background(Circle().fill(Valor.green.opacity(0.13)))
                Text(state.name)
                    .font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Valor.textTertiary)
            }
            .padding(14)
            .homeCardSurface()
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private var emptyState: some View {
        VStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 28))
                .foregroundStyle(Valor.textTertiary)
            Text("No states match \"\(searchText)\"")
                .font(.valorBody(15)).foregroundStyle(Valor.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}
