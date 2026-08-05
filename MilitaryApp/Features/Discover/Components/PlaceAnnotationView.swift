//
//  PlaceAnnotationView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A map pin for a place — a gift (free) or tag (discount) glyph on a tinted
/// circle. Used by both the Discover map and the Home preview with the iOS 16
/// `MapAnnotation` API.
struct PlaceAnnotationView: View {
    let isFree: Bool

    var body: some View {
        Image(systemName: isFree ? "gift.fill" : "tag.fill")
            .font(.system(size: 14, weight: .bold))
            .foregroundStyle(.white)
            .padding(8)
            .background(Circle().fill(isFree ? Color.green : Valor.blue))
            .shadow(color: .black.opacity(0.25), radius: 3, y: 1)
    }
}
