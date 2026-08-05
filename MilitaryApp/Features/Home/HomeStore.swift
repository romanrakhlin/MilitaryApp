//
//  HomeStore.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import Combine

/// Feature store for the Home dashboard: the configured (tracked) benefits
/// that sum into the headline total, the informational perks catalog, and the
/// disability-calculator tool state.
@MainActor
final class HomeStore: ObservableObject {

    @Published private(set) var entries: [TrackedBenefitEntry] = []
    @Published private(set) var savedRatings: [SavedRating] = []

    private let loadEntries: LoadTrackedBenefitsUseCase
    private let saveEntryUseCase: SaveTrackedBenefitUseCase
    private let removeEntryUseCase: RemoveTrackedBenefitUseCase
    private let loadRatings: LoadSavedRatingsUseCase
    private let saveRatingUseCase: SaveRatingUseCase
    private let deleteRatingUseCase: DeleteRatingUseCase
    private let combineRatings: CalculateCombinedRatingUseCase
    private let content: ContentRepository

    init(loadEntries: LoadTrackedBenefitsUseCase,
         saveEntry: SaveTrackedBenefitUseCase,
         removeEntry: RemoveTrackedBenefitUseCase,
         loadRatings: LoadSavedRatingsUseCase,
         saveRating: SaveRatingUseCase,
         deleteRating: DeleteRatingUseCase,
         combineRatings: CalculateCombinedRatingUseCase,
         content: ContentRepository) {
        self.loadEntries = loadEntries
        self.saveEntryUseCase = saveEntry
        self.removeEntryUseCase = removeEntry
        self.loadRatings = loadRatings
        self.saveRatingUseCase = saveRating
        self.deleteRatingUseCase = deleteRating
        self.combineRatings = combineRatings
        self.content = content
    }

    // MARK: Derived state

    /// The headline number: annual value across all configured benefits.
    var totalCents: Int { entries.reduce(0) { $0 + $1.annualValueCents } }

    func entry(for kind: TrackedBenefitKind) -> TrackedBenefitEntry? {
        entries.first { $0.kind == kind }
    }

    // MARK: Catalogs

    var creditCards: [MilitaryCreditCard] { content.creditCards() }

    func infoBenefits(in category: InfoBenefitCategory) -> [InfoBenefit] {
        content.infoBenefits().filter { $0.category == category }
    }

    var federalBenefits: [StateBenefit] { content.federalBenefits() }

    var stateGuides: [StateGuide] { content.stateGuides() }

    // MARK: Lifecycle

    func load() {
        entries = loadEntries()
        savedRatings = loadRatings()
    }

    // MARK: Tracked benefits

    func save(_ entry: TrackedBenefitEntry) {
        saveEntryUseCase(entry)
        withAnimation(.easeInOut) { entries = loadEntries() }
    }

    func removeEntry(kind: TrackedBenefitKind) {
        removeEntryUseCase(kind)
        withAnimation(.easeInOut) { entries = loadEntries() }
    }

    // MARK: Disability calculator

    func combine(_ ratings: [Int]) -> CombinedRating {
        combineRatings(ratings)
    }

    func saveRating(name: String, ratings: [Int]) {
        let combined = combineRatings(ratings)
        saveRatingUseCase(SavedRating(id: UUID(),
                                      name: name,
                                      ratings: ratings,
                                      exactPercent: combined.exactPercent,
                                      roundedPercent: combined.roundedPercent,
                                      monthlyCents: combined.monthlyCents,
                                      savedAt: Date()))
        withAnimation(.easeInOut) { savedRatings = loadRatings() }
    }

    func deleteRating(id: UUID) {
        deleteRatingUseCase(id)
        withAnimation(.easeInOut) { savedRatings = loadRatings() }
    }
}
