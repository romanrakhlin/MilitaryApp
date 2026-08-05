//
//  OptionButton.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A full-width selectable option row (branch, status, etc.).
///
/// The layout is deliberately identical in both states — text always leading,
/// a fixed-size radio indicator always reserved on the trailing edge — so
/// selecting an option never reflows or wraps the label.
struct OptionButton: View {
    let title: String
    var selected: Bool = false
    let action: () -> Void

    var body: some View {
        Button {
            Haptics.selection()
            action()
        } label: {
            HStack(spacing: 14) {
                Text(title)
                    .font(.valorButton(17))
                    .foregroundStyle(selected ? Valor.blue : Valor.textPrimary)
                    .lineLimit(1)
                Spacer(minLength: 12)
                indicator
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 18)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(selected ? AnyShapeStyle(Valor.blue.opacity(0.06))
                                   : AnyShapeStyle(Color.white))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .strokeBorder(
                        selected ? AnyShapeStyle(Valor.brandGradient)
                                 : AnyShapeStyle(Valor.cardStroke),
                        lineWidth: selected ? 1.5 : 1
                    )
            )
            .shadow(color: selected ? Valor.blue.opacity(0.20) : Color.black.opacity(0.05),
                    radius: selected ? 14 : 8,
                    y: selected ? 6 : 3)
            .contentShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        }
        .buttonStyle(ScaleButtonStyle(scale: 0.98))
        .animation(.spring(response: 0.3, dampingFraction: 0.75), value: selected)
    }

    /// Radio-style selection mark: hollow ring → gradient-filled circle with a
    /// white dot. Constant footprint in both states.
    private var indicator: some View {
        ZStack {
            Circle()
                .strokeBorder(Valor.textTertiary.opacity(0.45), lineWidth: 1.5)
                .opacity(selected ? 0 : 1)
            Circle()
                .fill(Valor.brandGradient)
                .opacity(selected ? 1 : 0)
            Circle()
                .fill(.white)
                .frame(width: 8, height: 8)
                .scaleEffect(selected ? 1 : 0.1)
                .opacity(selected ? 1 : 0)
        }
        .frame(width: 24, height: 24)
    }
}
