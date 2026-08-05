//
//  ContentRepository.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Editorial / sample content port: national chains, fallback articles, and
/// the benefit catalogs that aren't (yet) served by the backend.
protocol ContentRepository {
    func chains() -> [NationalChain]
    func articles() -> [Article]
    func creditCards() -> [MilitaryCreditCard]
    func infoBenefits() -> [InfoBenefit]
}
