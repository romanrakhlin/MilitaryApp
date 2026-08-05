//
//  DiscoverFloatingButtons.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The floating "List View" and "Add" buttons pinned to the bottom of the map.
struct DiscoverFloatingButtons: View {
    let onList: () -> Void
    let onAdd: () -> Void

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: onList) {
                    HStack(spacing: 8) {
                        Image(systemName: "list.bullet")
                        Text("List View").bold()
                    }
                    .font(.valorButton(16)).foregroundStyle(.black)
                    .padding(.horizontal, 18).padding(.vertical, 14)
                    .background(Capsule().fill(.white))
                    .shadow(radius: 6)
                }
                Spacer()
                Button(action: onAdd) {
                    HStack(spacing: 8) {
                        Image(systemName: "plus")
                        Text("Add").bold()
                    }
                    .font(.valorButton(16)).foregroundStyle(.white)
                    .padding(.horizontal, 20).padding(.vertical, 14)
                    .background(Capsule().fill(Valor.brandGradient))
                    .shadow(radius: 6)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 96)
        }
    }
}
