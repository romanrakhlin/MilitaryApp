//
//  HomeStore.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import Combine

/// Feature store for the Home dashboard. Loads the `HomeSummary` via its use
/// case and exposes fallback editorial content.
@MainActor
final class HomeStore: ObservableObject {
    @Published private(set) var home: HomeSummary?
    @Published private(set) var isLoading = false

    /// Fallback estimate shown before the server payload arrives.
    let estimatedAnnualValue = 28_902

    private let loadHome: LoadHomeUseCase
    private let content: ContentRepository

    init(loadHome: LoadHomeUseCase, content: ContentRepository) {
        self.loadHome = loadHome
        self.content = content
    }

    var fallbackArticles: [Article] { content.articles() }

    /// Loads on first appearance, only when authenticated.
    func loadIfNeeded(authenticated: Bool) async {
        guard home == nil, authenticated else { return }
        await load()
    }

    func refresh() async { await load() }

    private func load() async {
        isLoading = true
        defer { isLoading = false }
        if let summary = try? await loadHome() { home = summary }
    }
}
