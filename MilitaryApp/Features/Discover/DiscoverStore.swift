//
//  DiscoverStore.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import Combine

/// Feature store for the Discover map: nearby places, the Free/Discount mode
/// toggle, the category selection, and the national-chains content.
@MainActor
final class DiscoverStore: ObservableObject {
    enum Mode { case free, discount }

    @Published private(set) var places: [Place] = []
    /// nil = show every place; tapping a mode filters, tapping again clears.
    @Published var mode: Mode?
    @Published var category: DiscountCategory?

    private let loadPlaces: LoadPlacesUseCase
    private let content: ContentRepository

    init(loadPlaces: LoadPlacesUseCase, content: ContentRepository) {
        self.loadPlaces = loadPlaces
        self.content = content
    }

    var chains: [NationalChain] { content.chains() }

    var filtered: [Place] {
        places.filter { place in
            switch mode {
            case .free: return place.isFree
            case .discount: return !place.isFree
            case nil: return true
            }
        }
    }

    func loadIfNeeded() async {
        guard places.isEmpty else { return }
        if let result = try? await loadPlaces(lat: 38.8977, lng: -77.0365) { places = result }
    }
}
