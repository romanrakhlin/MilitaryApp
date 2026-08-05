//
//  PlacesListSheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A scrollable list of the currently-visible places, presented as a sheet
/// from the Discover map.
struct PlacesListSheet: View {
    let places: [Place]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(spacing: 12) {
                        HStack {
                            Text("\(places.count) places in this area")
                                .font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                            Spacer()
                            Text("Sorted by distance")
                                .font(.valorBody(13)).foregroundStyle(Valor.textSecondary)
                        }
                        .padding(.top, 8)

                        ForEach(places) { p in placeRow(p) }
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Discover")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }.foregroundStyle(Valor.green)
                }
            }
            .toolbarBackground(Valor.bgBottom, for: .navigationBar)
        }
        .preferredColorScheme(.light)
    }

    private func placeRow(_ p: Place) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(p.name).font(.valorButton(18)).foregroundStyle(Valor.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
                if let city = p.city {
                    Text(city).font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
                }
                Text(p.category ?? (p.isFree ? "Free" : "Discount"))
                    .font(.valorFont(12, weight: .bold))
                    .foregroundStyle(p.isFree ? Valor.green : .orange)
                    .padding(.horizontal, 10).padding(.vertical, 5)
                    .background(Capsule().fill((p.isFree ? Valor.green : .orange).opacity(0.18)))
            }
            Spacer()
            VStack(spacing: 10) {
                Text(p.distanceMiles.map { String(format: "%.1f mi", $0) } ?? "—")
                    .font(.valorButton(14)).foregroundStyle(Valor.blue)
                    .padding(.horizontal, 12).padding(.vertical, 6)
                    .background(Capsule().fill(Valor.blue.opacity(0.18)))
                Image(systemName: p.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(Valor.textSecondary)
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 16).fill(Valor.card.opacity(0.5)))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Valor.cardStroke))
    }
}
