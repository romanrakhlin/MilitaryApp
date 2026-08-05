//
//  Article.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// A benefits / career article surfaced on the Home dashboard.
struct Article: Identifiable {
    let id = UUID()
    let emoji: String
    let title: String
    let excerpt: String
    let tag: String
    let readMinutes: Int
}
