//
//  ArticleRow.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A single article row used in the Home "Latest Articles" list. Driven by
/// plain values so it renders both server and fallback articles.
struct ArticleRow: View {
    let emoji: String
    let title: String
    let excerpt: String
    let tag: String
    let readMinutes: Int

    var body: some View {
        let accent = tag.uppercased() == "CAREER" ? Color.orange : Valor.blue
        return HStack(spacing: 14) {
            Text(emoji).font(.system(size: 24))
                .frame(width: 52, height: 52)
                .background(Circle().fill(Valor.blue.opacity(0.08)))
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                    .lineLimit(2).fixedSize(horizontal: false, vertical: true)
                Text(excerpt).font(.valorBody(13)).foregroundStyle(Valor.textSecondary)
                    .lineLimit(1)
                HStack(spacing: 8) {
                    Text(tag.uppercased())
                        .font(.valorFont(11, weight: .bold))
                        .foregroundStyle(accent)
                        .padding(.horizontal, 10).padding(.vertical, 4)
                        .background(Capsule().strokeBorder(accent.opacity(0.5)))
                    Text("\(readMinutes) min read")
                        .font(.valorBody(12)).foregroundStyle(Valor.textTertiary)
                }
            }
            Spacer()
            Image(systemName: "chevron.right").foregroundStyle(Valor.textTertiary)
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 18).fill(Valor.card.opacity(0.45)))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.cardStroke))
    }
}
