//
//  PrimaryButton.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The primary gradient call-to-action button, with haptics and press scale.
/// Becoming enabled cross-fades gray → brand gradient and gives a small
/// celebratory pop + tick so the user notices it's ready.
struct PrimaryButton: View {
    let title: String
    var enabled: Bool = true
    let action: () -> Void

    /// Drives the brief scale pop when the button becomes enabled.
    @State private var pop = false

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
                        Color(red: 0.80, green: 0.83, blue: 0.88)   // muted gray when disabled
                        Valor.brandGradient.opacity(enabled ? 1 : 0) // cross-fades in when ready
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                .shadow(color: Valor.blue.opacity(enabled ? 0.38 : 0), radius: 20, y: 10)
                .shadow(color: Valor.blue.opacity(enabled ? 0.12 : 0), radius: 3, y: 1)
                .scaleEffect(pop ? 1.03 : 1)
        }
        .buttonStyle(ScaleButtonStyle())
        .disabled(!enabled)
        .animation(.easeInOut(duration: 0.25), value: enabled)
        .onChange(of: enabled) { isOn in
            guard isOn else { return }
            Haptics.selection()
            withAnimation(.spring(response: 0.28, dampingFraction: 0.55)) { pop = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { pop = false }
            }
        }
    }
}
