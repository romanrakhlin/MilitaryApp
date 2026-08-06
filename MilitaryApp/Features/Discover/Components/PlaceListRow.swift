//
//  PlaceListRow.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// One place card in the Discover List mode and the search screen: a
/// category icon in a tinted squircle, name + "city · category" line, and a
/// trailing Free/Discount badge over the distance.
struct PlaceListRow: View {
    let place: Place

    private var tint: Color { place.isFree ? Valor.green : Valor.blue }

    /// SF symbol matched to the backend category string, falling back to the
    /// free/discount glyph.
    private var icon: String {
        let category = place.category?.lowercased() ?? ""
        if category.contains("park") || category.contains("outdoor") { return "tree.fill" }
        if category.contains("va") || category.contains("benefit") { return "building.columns.fill" }
        if category.contains("museum") || category.contains("memorial") { return "building.columns.fill" }
        if category.contains("food") || category.contains("dining") { return "fork.knife" }
        if category.contains("auto") { return "car.fill" }
        if category.contains("shop") { return "bag.fill" }
        if category.contains("travel") || category.contains("lodging") || category.contains("hotel") { return "bed.double.fill" }
        if category.contains("entertain") { return "ticket.fill" }
        if category.contains("health") || category.contains("wellness") { return "heart.fill" }
        return place.isFree ? "gift.fill" : "tag.fill"
    }

    private var subtitle: String {
        [place.city, place.category].compactMap { $0 }.joined(separator: " · ")
    }

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(tint)
                .frame(width: 44, height: 44)
                .background(RoundedRectangle(cornerRadius: 13).fill(tint.opacity(0.12)))

            VStack(alignment: .leading, spacing: 3) {
                Text(place.name)
                    .font(.valorFont(16, weight: .semibold))
                    .foregroundStyle(Valor.textPrimary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                if !subtitle.isEmpty {
                    Text(subtitle)
                        .font(.valorBody(13))
                        .foregroundStyle(Valor.textSecondary)
                        .lineLimit(1)
                }
            }

            Spacer(minLength: 8)

            VStack(alignment: .trailing, spacing: 6) {
                Text(place.isFree ? "FREE" : "DISCOUNT")
                    .font(.valorFont(10, weight: .heavy))
                    .kerning(0.5)
                    .foregroundStyle(tint)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(tint.opacity(0.14)))
                if let miles = place.distanceMiles {
                    Text(String(format: "%.1f mi", miles))
                        .font(.valorFont(13, weight: .bold))
                        .foregroundStyle(Valor.textSecondary)
                }
            }
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 18).fill(Color.white))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.cardStroke))
        .shadow(color: .black.opacity(0.04), radius: 8, y: 2)
    }
}
