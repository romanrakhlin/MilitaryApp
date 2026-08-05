//
//  ExploreModule.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A tool tile shown in the Explore grid.
struct ExploreModule: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let tint: Color

    /// The static catalog of tools. (No dynamic state, so no store is needed.)
    static let all: [ExploreModule] = [
        .init(title: "Military Pay", subtitle: "Base, BAH, BAS & take-home", icon: "dollarsign.circle.fill", tint: .orange),
        .init(title: "TSP", subtitle: "Track & project retirement", icon: "chart.line.uptrend.xyaxis", tint: Valor.green),
        .init(title: "Credit Cards", subtitle: "Track benefits & credits", icon: "creditcard.fill", tint: Valor.blue),
        .init(title: "Airports", subtitle: "Lounges & travel perks", icon: "airplane", tint: .cyan),
        .init(title: "Health", subtitle: "TRICARE & VA care", icon: "cross.case.fill", tint: .pink),
        .init(title: "VA Disability", subtitle: "Ratings & pay tables", icon: "shield.lefthalf.filled", tint: Valor.red),
        .init(title: "Library", subtitle: "Guides & benefit articles", icon: "books.vertical.fill", tint: .purple),
        .init(title: "State Benefits", subtitle: "By state & residency", icon: "map.fill", tint: .teal)
    ]
}
