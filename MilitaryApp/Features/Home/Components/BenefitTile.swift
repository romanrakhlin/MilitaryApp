//
//  BenefitTile.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// One of the four tinted metric tiles (Cards / Income / TSP / Perks).
struct BenefitTile: View {
    let title: String
    let value: String
    var sub: String?
    let icon: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 18)).foregroundStyle(tint)
                .frame(width: 40, height: 40)
                .background(RoundedRectangle(cornerRadius: 12).fill(tint.opacity(0.2)))
            Spacer(minLength: 8)
            Text(title).font(.valorButton(17)).foregroundStyle(Valor.textPrimary)
            Text(value).font(.valorFont(24, weight: .black)).foregroundStyle(Valor.textPrimary)
            if let sub {
                Text(sub).font(.valorBody(12)).foregroundStyle(Valor.textTertiary)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 18).fill(tint.opacity(0.10)))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(tint.opacity(0.28)))
    }
}
