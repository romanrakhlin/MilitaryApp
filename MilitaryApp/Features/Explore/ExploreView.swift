//
//  ExploreView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The financial + benefit tools hub — a grid of `ModuleCard`s.
struct ExploreView: View {
    private let cols = Array(repeating: GridItem(.flexible(), spacing: 14), count: 2)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Explore").font(.valorTitle(32)).foregroundStyle(Valor.textPrimary)
                    Text("Track and maximize your benefits")
                        .font(.valorBody(15)).foregroundStyle(Valor.textSecondary)
                }
                .padding(.top, 8)

                LazyVGrid(columns: cols, spacing: 14) {
                    ForEach(ExploreModule.all) { module in
                        ModuleCard(module: module)
                    }
                }
                Color.clear.frame(height: 90)
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
        .scrollIndicators(.hidden)
    }
}
