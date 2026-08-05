//
//  UserProfile.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The captured profile — filled in during onboarding and refined from the
/// server. Pure value type with no framework dependencies.
struct UserProfile: Codable {
    var name: String = "Roman"
    var status: MilitaryStatus?
    var branch: Branch?
    var reserveComponent: ReserveComponent?
    var dutyStatus: DutyStatus?
    var payCategory: PayCategory?
    var payGrade: String?
    var yearsServed: Int?
    var goal: PrimaryGoal?
    var zip: String = ""
    var knowsTSP: Bool?
    var tspBalance: Double = 0
    var tspContributionPct: Double = 0
    var tspAllocation: [TSPFund: Double] = [:]
}
