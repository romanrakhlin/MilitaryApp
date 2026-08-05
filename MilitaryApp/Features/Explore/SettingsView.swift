//
//  SettingsView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The settings sheet presented from the Home dashboard.
struct SettingsView: View {
    @EnvironmentObject private var session: SessionStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        profileCard
                        section("Preferences", rows: [
                            ("bell.fill", "Notifications"),
                            ("location.fill", "Location"),
                            ("calendar", "Calendar sync"),
                            ("faceid", "Biometric unlock")
                        ])
                        section("Subscription", rows: [
                            ("crown.fill", "Manage plan"),
                            ("arrow.clockwise", "Restore purchases")
                        ])
                        section("Data", rows: [
                            ("square.and.arrow.up", "Export data"),
                            ("trash.fill", "Delete account")
                        ])

                        Button(role: .destructive) {
                            session.resetOnboarding(); dismiss()
                        } label: {
                            Text("Reset onboarding (dev)")
                                .font(.valorButton(15)).foregroundStyle(Valor.red)
                                .frame(maxWidth: .infinity).padding(.vertical, 14)
                                .background(RoundedRectangle(cornerRadius: 14).fill(Valor.red.opacity(0.12)))
                        }
                        .padding(.top, 8)
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }.foregroundStyle(Valor.green)
                }
            }
            .toolbarBackground(Valor.bgBottom, for: .navigationBar)
        }
        .preferredColorScheme(.light)
    }

    private var profileCard: some View {
        HStack(spacing: 14) {
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 44)).foregroundStyle(Valor.blue)
            VStack(alignment: .leading, spacing: 4) {
                Text(session.profile.name).font(.valorButton(20)).foregroundStyle(Valor.textPrimary)
                Text(profileSummary).font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
            }
            Spacer()
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 18).fill(Valor.card.opacity(0.5)))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.cardStroke))
    }

    private var profileSummary: String {
        [session.profile.status?.rawValue, session.profile.branch?.rawValue, session.profile.payGrade]
            .compactMap { $0 }
            .joined(separator: " · ")
    }

    private func section(_ title: String, rows: [(String, String)]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.valorFont(12, weight: .heavy))
                .foregroundStyle(Valor.textTertiary).tracking(1)
            VStack(spacing: 0) {
                ForEach(rows.indices, id: \.self) { i in
                    HStack(spacing: 14) {
                        Image(systemName: rows[i].0).foregroundStyle(Valor.textSecondary).frame(width: 24)
                        Text(rows[i].1).font(.valorBody(16)).foregroundStyle(Valor.textPrimary)
                        Spacer()
                        Image(systemName: "chevron.right").foregroundStyle(Valor.textTertiary)
                    }
                    .padding(.vertical, 14)
                    if i < rows.count - 1 { Divider().overlay(Valor.cardStroke) }
                }
            }
            .padding(.horizontal, 16)
            .background(RoundedRectangle(cornerRadius: 16).fill(Valor.card.opacity(0.5)))
            .overlay(RoundedRectangle(cornerRadius: 16).strokeBorder(Valor.cardStroke))
        }
    }
}
