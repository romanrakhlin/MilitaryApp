//
//  DiscoverEmptyHint.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The "no results" card overlaid on the map when the current search/filter
/// combination matches nothing.
struct DiscoverEmptyHint: View {
    let hasFilters: Bool
    let onClear: () -> Void

    var body: some View {
        HStack {
            Image(systemName: "mappin.slash").foregroundStyle(Valor.textSecondary)
            VStack(alignment: .leading, spacing: 2) {
                Text("No spots match")
                    .font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                Text(hasFilters ? "Try clearing your filters." : "Try panning the map.")
                    .font(.valorBody(13)).foregroundStyle(Valor.textSecondary)
            }
            Spacer()
            if hasFilters {
                Button(action: onClear) {
                    Text("Clear")
                        .font(.valorButton(14)).foregroundStyle(Valor.blue)
                        .padding(.horizontal, 14).padding(.vertical, 9)
                        .background(Capsule().fill(Valor.blue.opacity(0.12)))
                }
            }
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 16).fill(.regularMaterial))
        .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Valor.cardStroke))
        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
    }
}
