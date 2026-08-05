//
//  ChipButton.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A compact selectable chip (pay grade, years, filters).
struct ChipButton: View {
    let title: String
    var selected: Bool = false
    var action: () -> Void

    var body: some View {
        Button {
            Haptics.selection()
            action()
        } label: {
            Text(title)
                .font(.valorButton(16))
                .foregroundStyle(selected ? Valor.blue : Valor.textPrimary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(selected ? AnyShapeStyle(Valor.blue.opacity(0.08))
                                       : AnyShapeStyle(Valor.card))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .strokeBorder(
                            selected ? AnyShapeStyle(Valor.blue)
                                     : AnyShapeStyle(Valor.cardStroke),
                            lineWidth: selected ? 2 : 1
                        )
                )
        }
        .buttonStyle(ScaleButtonStyle(scale: 0.95))
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selected)
    }
}
