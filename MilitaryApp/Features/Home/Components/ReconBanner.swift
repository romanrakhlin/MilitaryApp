//
//  ReconBanner.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The "Recon" shortcut banner on the Home dashboard.
struct ReconBanner: View {
    let summary: HomeSummary?

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: "binoculars.fill")
                .font(.system(size: 20)).foregroundStyle(Valor.blue)
                .frame(width: 46, height: 46)
                .background(RoundedRectangle(cornerRadius: 12).fill(Valor.blue.opacity(0.15)))
            VStack(alignment: .leading, spacing: 2) {
                Text(summary?.recon.title ?? "Recon").font(.valorButton(18)).foregroundStyle(Valor.textPrimary)
                Text(summary?.recon.subtitle ?? "Find benefits near you")
                    .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(Valor.textTertiary)
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 18).fill(Valor.blue.opacity(0.06)))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.blue.opacity(0.2)))
    }
}
