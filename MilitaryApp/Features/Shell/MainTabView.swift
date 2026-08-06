//
//  MainTabView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The authenticated app shell: Home and the Map, in the native SwiftUI tab
/// bar tinted to the Valor accent. Threads the DI container down to each tab
/// so it can assemble its own store.
struct MainTabView: View {
    let container: AppContainer
    // `-openMap` launch argument (simctl launch … -openMap) boots straight to
    // the Map tab so automated runs can screenshot it without UI scripting.
    @State private var tab: ValorTab =
        ProcessInfo.processInfo.arguments.contains("-openMap") ? .map : .home

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
        case .home: HomeView(container: container)      // benefits dashboard
        case .map: DiscoverView(container: container)   // the map
        }
    }
}
