//
//  BenefitsRepositoryLive.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// UserDefaults-backed adapter for tracked benefits and saved ratings — this
/// data is device-local and not yet synced to the backend.
struct BenefitsRepositoryLive: BenefitsRepository {

    private static let entriesKey = "valor.trackedBenefits"
    private static let ratingsKey = "valor.savedRatings"

    // MARK: Tracked benefits

    func loadTrackedEntries() -> [TrackedBenefitEntry] {
        decode([TrackedBenefitEntry].self, key: Self.entriesKey) ?? []
    }

    func save(entry: TrackedBenefitEntry) {
        var entries = loadTrackedEntries().filter { $0.kind != entry.kind }
        entries.append(entry)
        encode(entries, key: Self.entriesKey)
    }

    func removeEntry(kind: TrackedBenefitKind) {
        encode(loadTrackedEntries().filter { $0.kind != kind }, key: Self.entriesKey)
    }

    // MARK: Saved ratings

    func loadSavedRatings() -> [SavedRating] {
        decode([SavedRating].self, key: Self.ratingsKey) ?? []
    }

    func save(rating: SavedRating) {
        var ratings = loadSavedRatings().filter { $0.id != rating.id }
        ratings.append(rating)
        encode(ratings, key: Self.ratingsKey)
    }

    func deleteRating(id: UUID) {
        encode(loadSavedRatings().filter { $0.id != id }, key: Self.ratingsKey)
    }

    // MARK: Codec helpers

    private func decode<T: Decodable>(_ type: T.Type, key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }

    private func encode<T: Encodable>(_ value: T, key: String) {
        if let data = try? JSONEncoder().encode(value) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
