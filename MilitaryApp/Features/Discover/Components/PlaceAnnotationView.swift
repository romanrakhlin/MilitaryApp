//
//  PlaceAnnotationView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A map pin for a place — a gift (free) or tag (discount) glyph on a tinted
/// circle with a white ring. Grows with a spring when its place is selected.
struct PlaceAnnotationView: View {
    let isFree: Bool
    var isSelected: Bool = false

    var body: some View {
        Image(systemName: isFree ? "gift.fill" : "tag.fill")
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(.white)
            .padding(8)
            .background(Circle().fill(isFree ? Valor.green : Valor.blue))
            .overlay(Circle().strokeBorder(.white, lineWidth: 2))
            .shadow(color: .black.opacity(0.25), radius: isSelected ? 5 : 3, y: 1)
            .scaleEffect(isSelected ? 1.3 : 1)
            .animation(.spring(duration: 0.3), value: isSelected)
    }
}
