//
//  MapSearchBar.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The frosted search field floating over the Discover map / list.
struct MapSearchBar: View {
    @Binding var text: String
    var focused: FocusState<Bool>.Binding

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Valor.textSecondary)

            TextField("Search places", text: $text)
                .font(.valorBody(16))
                .foregroundStyle(Valor.textPrimary)
                .focused(focused)
                .submitLabel(.search)
                .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(Valor.textTertiary)
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 14).fill(.regularMaterial))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
    }
}
