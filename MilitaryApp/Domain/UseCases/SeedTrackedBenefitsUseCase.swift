//
//  SeedTrackedBenefitsUseCase.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Converts the onboarding answers into starter tracked-benefit entries so the
/// dashboard shows a real total on first arrival instead of $0.
///
/// Every seeded entry stores its raw inputs, so the normal setup sheets open
/// pre-filled and the user can adjust or remove it. Runs only when nothing is
/// tracked yet — it never overwrites user-configured entries.
struct SeedTrackedBenefitsUseCase {
    let repository: BenefitsRepository

    func callAsFunction(profile: UserProfile) {
        guard repository.loadTrackedEntries().isEmpty else { return }

        // TSP match — current full-time members under BRS, assuming the
        // standard 5% contribution (the setup sheet's default, which earns the
        // full 5% agency match). Base pay is a per-grade estimate the user can
        // correct in the sheet.
        if isFullTime(profile), let grade = profile.payGrade,
           let payCents = Self.annualBasePayEstimateCents[grade] {
            repository.save(entry: TrackedBenefitEntry(
                kind: .tspMatch,
                annualValueCents: Int(Double(payCents) * 0.05),
                detail: "5% match on \(Self.usd(payCents)) est. \(grade) pay",
                annualBasePayCents: payCents,
                contributionPercent: 5))
        }

        // Commissary — every onboarding status keeps commissary access, so
        // start everyone from the sheet's average $600/mo grocery spend at its
        // 25% savings rate.
        let groceryCents = 600_00
        repository.save(entry: TrackedBenefitEntry(
            kind: .commissary,
            annualValueCents: Int(Double(groceryCents) * 0.25 * 12),
            detail: "~25% of \(Self.usd(groceryCents))/mo groceries est.",
            monthlyGroceryCents: groceryCents))
    }

    /// BRS matching applies to members currently drawing full-time pay.
    private func isFullTime(_ profile: UserProfile) -> Bool {
        profile.status == .activeDuty ||
        (profile.status == .reservesGuard &&
         (profile.dutyStatus == .agr || profile.dutyStatus == .mobilized))
    }

    /// Rough annual base pay by grade at typical time-in-service — a starting
    /// point for the estimate shown on the dashboard, not a pay table.
    private static let annualBasePayEstimateCents: [String: Int] = [
        "E-1": 24_000_00, "E-2": 27_000_00, "E-3": 29_000_00, "E-4": 33_000_00,
        "E-5": 38_000_00, "E-6": 45_000_00, "E-7": 52_000_00, "E-8": 61_000_00,
        "E-9": 74_000_00,
        "W-1": 55_000_00, "W-2": 62_000_00, "W-3": 71_000_00, "W-4": 80_000_00,
        "W-5": 92_000_00,
        "O-1": 46_000_00, "O-2": 58_000_00, "O-3": 72_000_00, "O-4": 85_000_00,
        "O-5": 100_000_00, "O-6": 120_000_00, "O-7": 141_000_00, "O-8": 160_000_00,
        "O-9": 176_000_00, "O-10": 192_000_00,
    ]

    private static func usd(_ cents: Int) -> String {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = "USD"
        f.maximumFractionDigits = 0
        return f.string(from: NSNumber(value: cents / 100)) ?? "$\(cents / 100)"
    }
}
