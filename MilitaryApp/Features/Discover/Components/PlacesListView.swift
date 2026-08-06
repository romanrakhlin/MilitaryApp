//
//  PlacesListView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The List mode of the Discover tab: the currently-filtered places as a
/// scrollable card list. Tapping a row hands the place back so the parent can
/// jump to it on the map.
struct PlacesListView: View {
    let places: [Place]
    var isLoading: Bool = false
    let onSelect: (Place) -> Void

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                HStack(alignment: .firstTextBaseline) {
                    Text("\(places.count) place\(places.count == 1 ? "" : "s")")
                        .font(.valorFont(20, weight: .bold))
                        .foregroundStyle(Valor.textPrimary)
                    Spacer()
                    Text("Sorted by distance")
                        .font(.valorBody(13))
                        .foregroundStyle(Valor.textTertiary)
                }
                .padding(.top, 6)
                .padding(.bottom, 4)

                if isLoading && places.isEmpty {
                    loadingState
                } else if places.isEmpty {
                    emptyState
                } else {
                    ForEach(places) { place in
                        Button {
                            onSelect(place)
                        } label: {
                            PlaceListRow(place: place)
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 100)   // clear the floating tab bar
        }
        .scrollDismissesKeyboard(.immediately)
        .background(Color(red: 0.97, green: 0.98, blue: 0.99))
    }

    private var loadingState: some View {
        VStack(spacing: 12) {
            ProgressView()
            Text("Finding places near you…")
                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }

    private var emptyState: some View {
        VStack(spacing: 10) {
            Image(systemName: "mappin.slash")
                .font(.system(size: 32))
                .foregroundStyle(Valor.textTertiary)
            Text("No places match")
                .font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
            Text("Try a different search or clear your filters.")
                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 60)
    }
}
