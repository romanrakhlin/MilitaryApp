//
//  DiscoverTopTabs.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// TikTok-style Map / List switcher floating at the top of the Discover tab.
/// Labels sit in fixed-width slots (constant bold weight, so nothing shifts
/// when selection changes) and a single blue underline slides between slot
/// centers with a spring.
struct DiscoverTopTabs: View {
    @Binding var selection: DiscoverStore.ViewMode

    private let tabs = DiscoverStore.ViewMode.allCases
    private let slotWidth: CGFloat = 68
    private let underlineWidth: CGFloat = 26

    private var selectedIndex: Int {
        tabs.firstIndex(of: selection) ?? 0
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                Button {
                    guard selection != tab else { return }
                    Haptics.selection()
                    withAnimation(.spring(response: 0.32, dampingFraction: 0.86)) {
                        selection = tab
                    }
                } label: {
                    Text(tab.rawValue)
                        .font(.valorFont(16, weight: .bold))
                        .foregroundStyle(selection == tab ? Valor.textPrimary : Valor.textSecondary.opacity(0.75))
                        .frame(width: slotWidth, height: 42)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
        }
        .overlay(alignment: .bottomLeading) {
            Capsule()
                .fill(Valor.blue)
                .frame(width: underlineWidth, height: 3)
                .offset(x: CGFloat(selectedIndex) * slotWidth + (slotWidth - underlineWidth) / 2, y: -5)
        }
        .padding(.horizontal, 6)
        .background(Capsule().fill(.regularMaterial))
        .overlay(Capsule().strokeBorder(Valor.cardStroke))
        .shadow(color: .black.opacity(0.08), radius: 8, y: 2)
        .animation(.spring(response: 0.32, dampingFraction: 0.86), value: selection)
    }
}
