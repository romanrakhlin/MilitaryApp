//
//  ProfileDTO.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// The server's user/profile payload. snake_case keys are mapped via
/// `JSONDecoder.convertFromSnakeCase`. Only fields the client uses are declared.
struct ProfileDTO: Decodable {
    struct Location: Decodable { let lat: Double; let lng: Double }
    struct TSP: Decodable {
        let balanceCents: Int?
        let contributionPct: Double?
        let allocation: [String: Double]?
    }
    let id: String
    let email: String?
    let name: String?
    let onboardingComplete: Bool?
    let status: String?
    let branch: String?
    let payCategory: String?
    let payGrade: String?
    let yearsServed: Int?
    let goal: String?
    let zip: String?
    let location: Location?
    let knowsTsp: Bool?
    let tsp: TSP?
}
