//
//  NationalChainsSheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A searchable directory of national brands offering military discounts.
struct NationalChainsSheet: View {
    let chains: [NationalChain]
    @Environment(\.dismiss) private var dismiss
    @State private var search = ""

    private var results: [NationalChain] {
        search.isEmpty ? chains
            : chains.filter { $0.name.localizedCaseInsensitiveContains(search) }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(alignment: .leading, spacing: 14) {
                        infoBanner
                        searchField
                        ForEach(results) { chain in chainRow(chain) }
                    }
                    .padding(20)
                }
            }
            .navigationTitle("National Chains")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }.foregroundStyle(Valor.textPrimary)
                }
            }
            .toolbarBackground(Valor.bgBottom, for: .navigationBar)
        }
        .preferredColorScheme(.light)
    }

    private var infoBanner: some View {
        HStack(spacing: 12) {
            Image(systemName: "building.2.fill")
                .font(.system(size: 20)).foregroundStyle(Valor.blue)
                .frame(width: 46, height: 46)
                .background(RoundedRectangle(cornerRadius: 12).fill(Valor.blue.opacity(0.2)))
            Text("\(chains.count) national brands with military discounts. Tap a brand to see locations near you.")
                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).fill(Valor.blue.opacity(0.10)))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Valor.blue.opacity(0.25)))
    }

    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundStyle(Valor.textSecondary)
            TextField("", text: $search,
                      prompt: Text("Search chains...").foregroundColor(Valor.textTertiary))
                .foregroundStyle(Valor.textPrimary)
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 14).fill(Valor.card.opacity(0.6)))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
    }

    private func chainRow(_ c: NationalChain) -> some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 3).fill(Color.orange).frame(width: 4)
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Text(c.name).font(.valorButton(18)).foregroundStyle(Valor.textPrimary)
                    if let badge = c.discountBadge {
                        Text(badge)
                            .font(.valorFont(12, weight: .bold))
                            .foregroundStyle(.orange)
                            .padding(.horizontal, 8).padding(.vertical, 3)
                            .background(Capsule().fill(Color.orange.opacity(0.2)))
                    }
                }
                Text(c.blurb).font(.valorBody(14)).foregroundStyle(Valor.blue)
                    .fixedSize(horizontal: false, vertical: true)
                Text("📍 \(c.locations) locations · tap to see near you")
                    .font(.valorBody(12)).foregroundStyle(Valor.textSecondary)
            }
            Spacer(minLength: 4)
            Image(systemName: "chevron.right").foregroundStyle(Valor.textTertiary)
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 16).fill(Valor.card.opacity(0.5)))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Valor.cardStroke))
    }
}
