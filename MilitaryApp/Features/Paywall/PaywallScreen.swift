//
//  PaywallScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import RevenueCat
import RevenueCatUI

/// Presents the remote (no-code) paywall for the current Offering, as designed
/// in the RevenueCat dashboard. Dismisses itself on purchase, restore, or the
/// paywall's own close button.
///
/// While no RevenueCat API key is set (`PurchasesManager.isConfigured` is
/// `false`) it shows a local setup placeholder instead, so the app remains
/// runnable end-to-end before the dashboard is wired up.
struct PaywallScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        if PurchasesManager.isConfigured {
            PaywallView(displayCloseButton: true)
                .onPurchaseCompleted { _ in dismiss() }
                .onRestoreCompleted { _ in dismiss() }
        } else {
            placeholder
        }
    }

    /// Shown only in development builds without an API key.
    private var placeholder: some View {
        VStack(spacing: 16) {
            Spacer()
            Text("👑").font(.system(size: 56))
            Text("Valor Pro")
                .font(.valorTitle(28)).foregroundStyle(Valor.textPrimary)
            Text("The RevenueCat paywall will appear here once the API key is set in PurchasesManager.swift.")
                .font(.valorBody(15)).foregroundStyle(Valor.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
            Spacer()
            PrimaryButton(title: "Close") { dismiss() }
                .padding(.horizontal, 20)
                .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(ValorBackground().ignoresSafeArea())
    }
}
