//
//  FilterChip.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A pill filter chip on the Discover map (All / Chains / categories).
struct FilterChip: View {
    let title: String
    var systemImage: String? = nil
    let active: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let systemImage { Image(systemName: systemImage) }
                Text(title).font(.valorButton(14))
            }
            .foregroundStyle(active ? .white : .black)
            .padding(.horizontal, 14).padding(.vertical, 10)
            .background(Capsule().fill(active ? AnyShapeStyle(Color.orange) : AnyShapeStyle(Color.white)))
            .shadow(radius: 3)
        }
    }
}
