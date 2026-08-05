//
//  TrackedBenefitEntry.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// A benefit the user has configured on the dashboard: the computed annual
/// value plus the raw inputs so the setup sheet can be re-opened for editing.
/// At most one entry exists per `TrackedBenefitKind`.
struct TrackedBenefitEntry: Codable, Identifiable, Equatable {
    var kind: TrackedBenefitKind
    var annualValueCents: Int
    /// Short human summary shown on the row, e.g. "3 cards · fees waived".
    var detail: String

    // Raw inputs, populated per kind.
    var cardIDs: [String]? = nil
    var disabilityPercent: Int? = nil
    var annualBasePayCents: Int? = nil
    var contributionPercent: Double? = nil
    var monthlyGroceryCents: Int? = nil

    var id: String { kind.rawValue }
}
