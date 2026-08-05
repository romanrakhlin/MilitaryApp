//
//  HomeCardStyle.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

extension View {
    /// The borderless elevated cell surface used across the Home dashboard:
    /// white card, soft shadow, no stroke.
    func homeCardSurface(cornerRadius: CGFloat = 20) -> some View {
        background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.07), radius: 14, y: 5)
        )
    }
}
