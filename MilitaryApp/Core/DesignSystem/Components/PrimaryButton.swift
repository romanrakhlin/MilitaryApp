//
//  PrimaryButton.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The primary gradient call-to-action button, with haptics and press scale.
struct PrimaryButton: View {
    let title: String
    var enabled: Bool = true
    let action: () -> Void

    var body: some View {
        Button {
            Haptics.impact(.medium)
            action()
        } label: {
            Text(title)
                .font(.valorButton())
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    ZStack {
                        if enabled { Valor.brandGradient }
                        else { Color(red: 0.80, green: 0.83, blue: 0.88) }  // muted gray when disabled
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                .shadow(color: Valor.blue.opacity(enabled ? 0.38 : 0), radius: 20, y: 10)
                .shadow(color: Valor.blue.opacity(enabled ? 0.12 : 0), radius: 3, y: 1)
        }
        .buttonStyle(ScaleButtonStyle())
        .disabled(!enabled)
        .animation(.easeInOut(duration: 0.2), value: enabled)
    }
}
