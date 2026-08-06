//
//  PurchasesManager.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation
import Combine
import RevenueCat

/// Thin app-wide wrapper around the RevenueCat SDK: configures it once at
/// launch and mirrors the "pro" entitlement into a published flag.
///
/// Paywall layouts are designed no-code in the RevenueCat dashboard and
/// fetched remotely — see `PaywallScreen` for presentation.
@MainActor
final class PurchasesManager: ObservableObject {

    static let shared = PurchasesManager()

    /// The *public* Apple API key from RevenueCat → Project settings → API
    /// keys (starts with `appl_`).
    static let apiKey = "appl_aSrLGvNpbMynSFKVLgwjGxdBeTC"

    /// Entitlement identifier as configured in the RevenueCat dashboard.
    static let proEntitlementID = "pro"

    /// `false` until a real API key is pasted above — the app still runs, and
    /// `PaywallScreen` shows a setup placeholder instead of a remote paywall.
    static var isConfigured: Bool { !apiKey.contains("REPLACE") }

    @Published private(set) var isPro = false

    private init() {}

    /// Call once from the app's entry point, before any view needs purchases.
    static func configure() {
        guard isConfigured else {
            print("[Purchases] RevenueCat API key not set — paywalls show a placeholder.")
            return
        }
        Purchases.logLevel = .warn
        Purchases.configure(withAPIKey: apiKey)
        shared.observeCustomerInfo()
    }

    /// Mirrors entitlement changes (purchases, restores, renewals) into `isPro`.
    private func observeCustomerInfo() {
        Task {
            for await info in Purchases.shared.customerInfoStream {
                isPro = info.entitlements[Self.proEntitlementID]?.isActive == true
            }
        }
    }
}
