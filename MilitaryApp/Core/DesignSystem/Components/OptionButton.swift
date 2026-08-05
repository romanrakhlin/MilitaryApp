//
//  OptionButton.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A full-width selectable option row (branch, status, etc.) with a selected
/// state, checkmark, and haptics.
struct OptionButton: View {
    let title: String
    var selected: Bool = false
    let action: () -> Void

    var body: some View {
        Button {
            Haptics.selection()
            action()
        } label: {
            HStack {
                Text(title)
                    .font(.valorButton(18))
                    .foregroundStyle(selected ? Valor.blue : Valor.textPrimary)
                if selected {
                    Spacer(minLength: 8)
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(Valor.blue)
                        .transition(.scale.combined(with: .opacity))
                }
            }
            .frame(maxWidth: .infinity, alignment: selected ? .leading : .center)
            .padding(.horizontal, selected ? 20 : 0)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(selected ? AnyShapeStyle(Valor.blue.opacity(0.08))
                                   : AnyShapeStyle(Valor.card))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .strokeBorder(
                        selected ? AnyShapeStyle(Valor.blue)
                                 : AnyShapeStyle(Valor.cardStroke),
                        lineWidth: selected ? 2 : 1
                    )
            )
            .shadow(color: Valor.blue.opacity(selected ? 0.18 : 0), radius: 12, y: 4)
        }
        .buttonStyle(ScaleButtonStyle())
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: selected)
    }
}
