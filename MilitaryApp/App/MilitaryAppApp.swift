//
//  MilitaryAppApp.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The composition root. Builds the DI container, creates the app-wide
/// `SessionStore` from it, and injects both into the view tree.
@main
struct MilitaryAppApp: App {
    private let container: AppContainer
    @StateObject private var session: SessionStore

    init() {
        PurchasesManager.configure()
        let container = AppContainer()
        self.container = container
        _session = StateObject(wrappedValue: container.makeSessionStore())
    }

    var body: some Scene {
        WindowGroup {
            RootCoordinatorView(container: container)
                .environmentObject(session)
                .environment(\.font, .valorFont(17))
                .preferredColorScheme(.light)
        }
    }
}
