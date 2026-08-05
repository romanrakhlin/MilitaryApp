//
//  PerkCategoryButton.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// One of the category buttons in the Perks & Discounts section. Tapping it
/// opens the fullscreen category browser.
struct PerkCategoryButton: View {
    let category: InfoBenefitCategory
    let count: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: category.icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(category.tint)
                    .frame(width: 48, height: 48)
                    .background(Circle().fill(category.tint.opacity(0.13)))
                VStack(spacing: 2) {
                    Text(category.rawValue)
                        .font(.valorButton(15)).foregroundStyle(Valor.textPrimary)
                    Text("\(count) \(category.unitLabel)")
                        .font(.valorBody(12)).foregroundStyle(Valor.textTertiary)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 18)
            .homeCardSurface()
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
