//
//  ToolRow.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A row in the "Tools" section of the Home dashboard.
struct ToolRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18)).foregroundStyle(tint)
                    .frame(width: 44, height: 44)
                    .background(RoundedRectangle(cornerRadius: 13).fill(tint.opacity(0.14)))
                VStack(alignment: .leading, spacing: 3) {
                    Text(title).font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                    Text(subtitle).font(.valorBody(13)).foregroundStyle(Valor.textSecondary)
                }
                Spacer(minLength: 8)
                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Valor.textTertiary)
            }
            .padding(14)
            .background(RoundedRectangle(cornerRadius: 18).fill(Valor.card.opacity(0.5)))
            .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.cardStroke))
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
