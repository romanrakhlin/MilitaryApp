//
//  QualifyScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A summary of what the member qualifies for, in a gradient-bordered card.
struct QualifyScreen: View {
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            OBTitle(title: "Based on your profile, here's what you qualify for.",
                    alignment: .center).padding(.top, 8)

            GradientBorderCard {
                VStack(spacing: 0) {
                    qualifyRow(icon: "checkmark.seal.fill", tint: Valor.blue, label: "Benefits", value: "14")
                    Divider().overlay(Valor.cardStroke).padding(.vertical, 14)
                    qualifyRow(icon: "mappin.circle.fill", tint: Valor.blue, label: "Local discounts", value: "112")
                    Divider().overlay(Valor.cardStroke).padding(.vertical, 14)
                    qualifyRow(icon: "clock.fill", tint: Valor.blue, label: "Expiring soon", value: "3")
                }
            }
            Spacer()
            PrimaryButton(title: "Continue", action: onNext).padding(.bottom, 20)
        }
        .obPadding().padding(.top, 24)
    }

    private func qualifyRow(icon: String, tint: Color, label: String, value: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 18))
                .foregroundStyle(tint)
                .frame(width: 42, height: 42)
                .background(RoundedRectangle(cornerRadius: 12).fill(tint.opacity(0.18)))
            Text(label).font(.valorButton(18)).foregroundStyle(Valor.textPrimary).padding(.leading, 6)
            Spacer()
            Text(value).font(.valorFont(34, weight: .black)).foregroundStyle(Valor.textPrimary)
        }
    }
}
