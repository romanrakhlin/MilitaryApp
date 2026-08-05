//
//  ProfilePatch.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Partial profile update sent during onboarding. Optional fields with nil are
/// omitted from the JSON (synthesized Encodable uses `encodeIfPresent`).
struct ProfilePatch: Encodable {
    var status: String?
    var branch: String?
    var reserveComponent: String?
    var dutyStatus: String?
    var payCategory: String?
    var payGrade: String?
    var yearsServed: Int?
    var goal: String?
    var zip: String?
    var knowsTsp: Bool?
}
