//
//  FilterSheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The half-height filter sheet for the Discover map: Free/Discount type
/// toggle, category grid, and the National Chains directory entry point.
struct FilterSheet: View {
    @ObservedObject var store: DiscoverStore
    @Environment(\.dismiss) private var dismiss
    @State private var showChains = false

    private let columns = [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    section("Type") {
                        HStack(spacing: 10) {
                            ModeButton(title: "Free", icon: "gift.fill", active: store.mode == .free) {
                                Haptics.selection()
                                store.mode = (store.mode == .free ? nil : .free)
                            }
                            ModeButton(title: "Discount", icon: "tag.fill", active: store.mode == .discount) {
                                Haptics.selection()
                                store.mode = (store.mode == .discount ? nil : .discount)
                            }
                        }
                    }

                    section("Category") {
                        LazyVGrid(columns: columns, spacing: 10) {
                            FilterChip(title: "All", active: store.category == nil) {
                                Haptics.selection()
                                store.category = nil
                            }
                            ForEach(DiscountCategory.allCases) { c in
                                FilterChip(title: c.rawValue, active: store.category == c) {
                                    Haptics.selection()
                                    store.category = c
                                }
                            }
                        }
                    }

                    section("More") {
                        Button { showChains = true } label: {
                            HStack {
                                Image(systemName: "building.2.fill").foregroundStyle(Valor.blue)
                                Text("National Chains")
                                    .font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Valor.textTertiary)
                            }
                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 14).fill(Valor.card.opacity(0.5)))
                            .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
                .padding(20)
            }
            .background(Color.white)
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    if store.activeFilterCount > 0 {
                        Button("Reset") { store.clearFilters() }
                            .foregroundStyle(Valor.blue)
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .bold()
                        .foregroundStyle(Valor.blue)
                }
            }
        }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .sheet(isPresented: $showChains) { NationalChainsSheet(chains: store.chains) }
    }

    private func section(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title.uppercased())
                .font(.valorFont(12, weight: .bold))
                .foregroundStyle(Valor.textSecondary)
                .kerning(0.8)
            content()
        }
    }
}
