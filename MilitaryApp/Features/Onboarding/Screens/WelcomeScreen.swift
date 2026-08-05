//
//  WelcomeScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The full-bleed welcome screen.
struct WelcomeScreen: View {
    let onStart: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Text("Every benefit you've earned. On one app.")
                .font(.valorTitle(40))
                .foregroundStyle(Valor.textPrimary)
                .multilineTextAlignment(.center)
                .obPadding()
            Spacer()
            PrimaryButton(title: "Get started", action: onStart)
                .obPadding()
                .padding(.bottom, 20)
        }
    }
}
