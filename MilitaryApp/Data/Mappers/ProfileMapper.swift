//
//  ProfileMapper.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Converts between the server `ProfileDTO` and the domain `Account`/`UserProfile`.
enum ProfileMapper {

    static func account(from dto: ProfileDTO) -> Account {
        Account(id: dto.id,
                email: dto.email,
                onboardingComplete: dto.onboardingComplete ?? false,
                profile: profile(from: dto))
    }

    static func profile(from dto: ProfileDTO) -> UserProfile {
        var p = UserProfile()
        if let n = dto.name, !n.isEmpty { p.name = n }
        p.status = MilitaryStatus.from(apiValue: dto.status)
        p.branch = Branch.from(apiValue: dto.branch)
        p.payCategory = PayCategory.from(apiValue: dto.payCategory) ?? p.payCategory
        p.payGrade = dto.payGrade
        p.yearsServed = dto.yearsServed
        p.goal = PrimaryGoal.from(apiValue: dto.goal)
        if let z = dto.zip { p.zip = z }
        p.knowsTSP = dto.knowsTsp
        if let tsp = dto.tsp {
            if let cents = tsp.balanceCents { p.tspBalance = Double(cents) / 100 }
            if let pct = tsp.contributionPct { p.tspContributionPct = pct }
        }
        return p
    }

    /// The partial update body sent to `PATCH /me` during onboarding.
    static func patch(from p: UserProfile) -> ProfilePatch {
        ProfilePatch(
            status: p.status?.apiValue,
            branch: p.branch?.apiValue,
            reserveComponent: p.reserveComponent?.apiValue,
            dutyStatus: p.dutyStatus?.apiValue,
            payCategory: p.payCategory?.apiValue,
            payGrade: p.payGrade,
            yearsServed: p.yearsServed,
            goal: p.goal?.apiValue,
            zip: p.zip.isEmpty ? nil : p.zip,
            knowsTsp: p.knowsTSP
        )
    }
}
