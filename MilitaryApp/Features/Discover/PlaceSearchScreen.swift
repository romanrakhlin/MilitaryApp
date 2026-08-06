//
//  PlaceSearchScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The full-screen search experience (TikTok-style): an auto-focused search
/// field with a Cancel button, and live results over every loaded place.
/// Tapping a result closes search and focuses that place on the map.
struct PlaceSearchScreen: View {
    @ObservedObject var store: DiscoverStore
    @Environment(\.dismiss) private var dismiss
    @FocusState private var searchFocused: Bool

    private var trimmedQuery: String {
        store.query.trimmingCharacters(in: .whitespaces)
    }

    private var results: [Place] {
        guard !trimmedQuery.isEmpty else { return store.places }
        return store.places.filter { place in
            place.name.localizedCaseInsensitiveContains(trimmedQuery)
                || (place.city?.localizedCaseInsensitiveContains(trimmedQuery) ?? false)
                || (place.category?.localizedCaseInsensitiveContains(trimmedQuery) ?? false)
        }
    }

    private var sectionTitle: String {
        trimmedQuery.isEmpty
            ? "Nearby"
            : "\(results.count) result\(results.count == 1 ? "" : "s")"
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                MapSearchBar(text: $store.query, focused: $searchFocused)
                Button("Cancel") {
                    store.query = ""
                    dismiss()
                }
                .font(.valorFont(16, weight: .semibold))
                .foregroundStyle(Valor.blue)
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
            .padding(.bottom, 14)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    if !results.isEmpty {
                        Text(sectionTitle.uppercased())
                            .font(.valorFont(12, weight: .bold))
                            .kerning(0.8)
                            .foregroundStyle(Valor.textTertiary)
                            .padding(.bottom, 2)
                    }

                    if results.isEmpty {
                        emptyState
                    } else {
                        ForEach(results) { place in
                            Button {
                                select(place)
                            } label: {
                                PlaceListRow(place: place)
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
            .scrollDismissesKeyboard(.immediately)
        }
        .background(Color(red: 0.97, green: 0.98, blue: 0.99).ignoresSafeArea())
        .onAppear {
            // Focus after the cover's presentation animation settles.
            Task {
                try? await Task.sleep(for: .seconds(0.45))
                searchFocused = true
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 32))
                .foregroundStyle(Valor.textTertiary)
            Text("No results for \u{201C}\(trimmedQuery)\u{201D}")
                .font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                .multilineTextAlignment(.center)
            Text("Try a different name, city, or category.")
                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }

    private func select(_ place: Place) {
        Haptics.selection()
        store.query = ""
        store.selectedPlaceID = place.id
        store.viewMode = .map
        dismiss()
    }
}
