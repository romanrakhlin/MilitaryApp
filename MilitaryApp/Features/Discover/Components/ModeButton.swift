//
//  ModeButton.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The full-width Free / Discount toggle buttons in the filter sheet.
struct ModeButton: View {
    let title: String
    let icon: String
    let active: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title).font(.valorButton(15)).lineLimit(1).minimumScaleFactor(0.8)
            }
            .foregroundStyle(active ? .white : Valor.textPrimary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 13)
            .background(Capsule().fill(active ? AnyShapeStyle(Valor.blue) : AnyShapeStyle(Valor.card)))
            .overlay(Capsule().strokeBorder(active ? Color.clear : Valor.cardStroke))
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
