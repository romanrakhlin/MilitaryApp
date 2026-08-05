//
//  OnboardingBottomBar.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

extension View {
    /// Wraps a pinned Continue button so scrolling content dissolves into the
    /// background behind it instead of bleeding through a transparent bar.
    func onboardingBottomBar() -> some View {
        self
            .padding(.horizontal, 24)
            .padding(.top, 16)
            .padding(.bottom, 12)
            .background(
                LinearGradient(
                    colors: [Valor.bgTop.opacity(0), Valor.bgTop, Valor.bgTop],
                    startPoint: .top, endPoint: .bottom
                )
                .ignoresSafeArea(edges: .bottom)
            )
    }
}
