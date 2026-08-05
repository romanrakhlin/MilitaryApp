//
//  SettingsDropdown.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Custom dropdown for the settings button. Built in SwiftUI (rather than
/// `Menu`) so the items can carry the accent color — system menus force
/// black labels.
struct SettingsDropdown: View {
    let privacyURL: String
    let onUpgrade: () -> Void
    let onDeleteAccount: () -> Void
    let onClose: () -> Void

    @State private var showingAccount = false
    @Environment(\.openURL) private var openURL

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if showingAccount { accountLevel } else { mainLevel }
        }
        .frame(width: 230)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.16), radius: 22, y: 8)
        )
    }

    // MARK: Levels

    private var mainLevel: some View {
        Group {
            row(icon: "crown.fill", text: "Upgrade to Pro") {
                onClose(); onUpgrade()
            }
            divider
            row(icon: "person.crop.circle", text: "Account", trailing: "chevron.right") {
                withAnimation(.easeInOut(duration: 0.15)) { showingAccount = true }
            }
            divider
            row(icon: "hand.raised.fill", text: "Privacy Policy") {
                onClose()
                if let url = URL(string: privacyURL) { openURL(url) }
            }
        }
    }

    private var accountLevel: some View {
        Group {
            row(icon: "chevron.left", text: "Back", tint: Valor.textSecondary) {
                withAnimation(.easeInOut(duration: 0.15)) { showingAccount = false }
            }
            divider
            row(icon: "trash", text: "Delete Account", tint: Valor.red) {
                onClose(); onDeleteAccount()
            }
        }
    }

    // MARK: Pieces

    private var divider: some View {
        Divider().overlay(Valor.cardStroke).padding(.leading, 46)
    }

    private func row(icon: String, text: String, trailing: String? = nil,
                     tint: Color = Valor.blue, action: @escaping () -> Void) -> some View {
        Button {
            Haptics.selection()
            action()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(tint)
                    .frame(width: 22)
                Text(text)
                    .font(.valorButton(15))
                    .foregroundStyle(tint)
                Spacer(minLength: 0)
                if let trailing {
                    Image(systemName: trailing)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Valor.textTertiary)
                }
            }
            .padding(.horizontal, 14).padding(.vertical, 13)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
