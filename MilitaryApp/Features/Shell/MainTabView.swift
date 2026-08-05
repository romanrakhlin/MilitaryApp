//
//  MainTabView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The authenticated app shell: Home, Explore, and the Map, in the native
/// SwiftUI tab bar tinted to the Valor accent. Threads the DI container down
/// to each tab so it can assemble its own store.
struct MainTabView: View {
    let container: AppContainer
    @State private var tab: ValorTab = .home

    var body: some View {
        TabView(selection: $tab) {
            ForEach(ValorTab.allCases) { t in
                tabContent(t)
                    .tabItem { Label(t.rawValue, systemImage: t.icon) }
                    .tag(t)
            }
        }
        .tint(Valor.blue)
    }

    @ViewBuilder
    private func tabContent(_ t: ValorTab) -> some View {
        switch t {
        case .home: HomeView(container: container)     // benefits dashboard is the primary screen
        case .explore: ExploreView()
        case .map: DiscoverView(container: container)   // the map
        }
    }
}
