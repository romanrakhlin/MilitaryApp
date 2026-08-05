//
//  HomeView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Personalized dashboard: total tracked benefit value, the Cards / Income /
/// TSP / Perks tiles, a Recon shortcut, a map preview, and latest articles.
struct HomeView: View {
    @EnvironmentObject private var session: SessionStore
    @StateObject private var store: HomeStore
    @State private var showSettings = false

    init(container: AppContainer) {
        _store = StateObject(wrappedValue: container.makeHomeStore())
    }

    private var greeting: String {
        let h = Calendar.current.component(.hour, from: Date())
        switch h {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }

    private var headerTitle: String {
        if let g = store.home?.greeting { return "Good \(g.partOfDay), \(g.name ?? session.profile.name)" }
        return "\(greeting), \(session.profile.name)"
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HomeHeader(title: headerTitle) { showSettings = true }
                    TrackedValueCard(summary: store.home, estimatedAnnualValue: store.estimatedAnnualValue)
                    ReconBanner(summary: store.home)
                    HomeMapPreview(preview: store.home?.mapPreview)
                    articlesSection
                    Color.clear.frame(height: 24)
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .background(ValorBackground().ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Benefits")
                        .font(.valorFont(20, weight: .black))
                        .foregroundStyle(Valor.textPrimary)
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .sheet(isPresented: $showSettings) { SettingsView() }
        .task { await store.loadIfNeeded(authenticated: session.isAuthenticated) }
        .refreshable { await store.refresh() }
    }

    // MARK: Articles

    private var articlesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Latest Articles").font(.valorTitle(24)).foregroundStyle(Valor.textPrimary)
            if let serverArticles = store.home?.latestArticles, !serverArticles.isEmpty {
                ForEach(serverArticles) { a in
                    ArticleRow(emoji: a.emoji, title: a.title, excerpt: a.excerpt,
                               tag: a.tag, readMinutes: a.readMinutes)
                }
            } else {
                ForEach(store.fallbackArticles) { a in
                    ArticleRow(emoji: a.emoji, title: a.title, excerpt: a.excerpt,
                               tag: a.tag, readMinutes: a.readMinutes)
                }
            }
        }
    }
}
