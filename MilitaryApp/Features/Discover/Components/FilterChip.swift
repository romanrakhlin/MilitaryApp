//
//  FilterChip.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A pill filter chip in the Discover filter sheet (All / categories).
struct FilterChip: View {
    let title: String
    var systemImage: String? = nil
    let active: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let systemImage { Image(systemName: systemImage) }
                Text(title).font(.valorButton(14)).lineLimit(1).minimumScaleFactor(0.8)
            }
            .foregroundStyle(active ? .white : Valor.textPrimary)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12).padding(.vertical, 11)
            .background(Capsule().fill(active ? AnyShapeStyle(Valor.blue) : AnyShapeStyle(Valor.card)))
            .overlay(Capsule().strokeBorder(active ? Color.clear : Valor.cardStroke))
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
