//
//  HomeHeader.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The greeting + settings-gear header at the top of the Home dashboard.
struct HomeHeader: View {
    let title: String
    let onSettings: () -> Void

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.valorTitle(28)).foregroundStyle(Valor.textPrimary)
                Text("Track and Maximize Your Benefits")
                    .font(.valorBody(15)).foregroundStyle(Valor.textSecondary)
            }
            Spacer()
            Button(action: onSettings) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 22)).foregroundStyle(Valor.textSecondary)
            }
        }
        .padding(.top, 8)
    }
}
