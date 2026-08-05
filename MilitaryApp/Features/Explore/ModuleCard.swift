//
//  ModuleCard.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A single tool card in the Explore grid.
struct ModuleCard: View {
    let module: ExploreModule

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: module.icon)
                .font(.system(size: 22)).foregroundStyle(module.tint)
                .frame(width: 48, height: 48)
                .background(RoundedRectangle(cornerRadius: 14).fill(module.tint.opacity(0.2)))
            Spacer(minLength: 6)
            Text(module.title).font(.valorButton(18)).foregroundStyle(Valor.textPrimary)
            Text(module.subtitle).font(.valorBody(13)).foregroundStyle(Valor.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 20).fill(Valor.card.opacity(0.5)))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Valor.cardStroke))
    }
}
