//
//  DiscoverEmptyHint.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The "no results" card overlaid on the map when the current filter is empty.
struct DiscoverEmptyHint: View {
    let mode: DiscoverStore.Mode?

    private var modeWord: String {
        switch mode {
        case .free: return "free "
        case .discount: return "discount "
        case nil: return ""
        }
    }

    var body: some View {
        HStack {
            Image(systemName: "mappin.slash").foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 2) {
                Text("No \(modeWord)spots here")
                    .font(.valorButton(16)).foregroundStyle(.black)
                Text("Try panning, or use Find nearest.")
                    .font(.valorBody(13)).foregroundStyle(.secondary)
            }
            Spacer()
            Text("Find nearest")
                .font(.valorButton(14)).foregroundStyle(.black)
                .padding(.horizontal, 14).padding(.vertical, 10)
                .background(Capsule().strokeBorder(.black.opacity(0.4)))
        }
        .padding(14)
        .background(RoundedRectangle(cornerRadius: 16).fill(.white))
        .shadow(radius: 6)
    }
}
