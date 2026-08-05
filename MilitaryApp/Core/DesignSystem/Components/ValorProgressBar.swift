//
//  ValorProgressBar.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A rounded gradient progress bar with a soft glow, used in onboarding chrome.
struct ValorProgressBar: View {
    /// 0...1
    let progress: Double
    var height: CGFloat = 7

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.black.opacity(0.07))
                Capsule()
                    .fill(Valor.brandGradient)
                    .frame(width: max(height, geo.size.width * min(max(progress, 0), 1)))
                    .shadow(color: Valor.blue.opacity(0.45), radius: 4, y: 0)
                    .animation(.spring(response: 0.45, dampingFraction: 0.85), value: progress)
            }
        }
        .frame(height: height)
    }
}
