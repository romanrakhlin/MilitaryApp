//
//  HomeSectionHeader.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Title + supporting line introducing each Home dashboard section.
struct HomeSectionHeader: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title).font(.valorTitle(24)).foregroundStyle(Valor.textPrimary)
            Text(subtitle).font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
        }
        .padding(.top, 8)
    }
}
