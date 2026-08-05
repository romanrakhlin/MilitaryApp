//
//  TSPMatchSheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Setup sheet for the TSP Match benefit: annual base pay + contribution
/// percentage → the BRS agency match you're collecting (up to 5% of pay).
struct TSPMatchSheet: View {
    @ObservedObject var store: HomeStore
    @Environment(\.dismiss) private var dismiss

    @State private var basePayText: String
    @State private var contribution: Double

    init(store: HomeStore) {
        self.store = store
        let entry = store.entry(for: .tspMatch)
        _basePayText = State(initialValue: entry.map { String($0.annualBasePayCents.map { $0 / 100 } ?? 0) } ?? "")
        _contribution = State(initialValue: entry?.contributionPercent ?? 5)
    }

    private var basePayCents: Int { (Int(basePayText) ?? 0) * 100 }

    /// BRS match: 1% automatic + dollar-for-dollar on the first 3% you
    /// contribute + 50¢ on the dollar for the next 2%. Maxes out at 5%.
    private var matchPercent: Double {
        1 + min(contribution, 3) + max(0, min(contribution - 3, 2)) * 0.5
    }

    private var annualMatchCents: Int {
        Int(Double(basePayCents) * matchPercent / 100)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Under the Blended Retirement System, the government matches your TSP contributions up to 5% of base pay — free money if you contribute at least 5%.")
                            .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("ANNUAL BASE PAY")
                                .font(.valorFont(12, weight: .heavy))
                                .foregroundStyle(Valor.textTertiary).tracking(1)
                            HStack {
                                Text("$").font(.valorFont(20, weight: .bold)).foregroundStyle(Valor.textSecondary)
                                TextField("48,000", text: $basePayText)
                                    .keyboardType(.numberPad)
                                    .font(.valorFont(20, weight: .bold))
                                    .foregroundStyle(Valor.textPrimary)
                            }
                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 14).fill(Valor.card.opacity(0.5)))
                            .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("YOU CONTRIBUTE  ·  \(Int(contribution))%")
                                .font(.valorFont(12, weight: .heavy))
                                .foregroundStyle(Valor.textTertiary).tracking(1)
                            Slider(value: $contribution, in: 0...15, step: 1)
                                .tint(Valor.green)
                        }

                        resultCard
                        Color.clear.frame(height: 90)
                    }
                    .padding(20)
                }
                .scrollIndicators(.hidden)
                .onTapGesture { dismissKeyboard() }

                saveBar
            }
            .navigationTitle("TSP Match")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }.foregroundStyle(Valor.textSecondary)
                }
                if store.entry(for: .tspMatch) != nil {
                    ToolbarItem(placement: .destructiveAction) {
                        Button("Remove") {
                            store.removeEntry(kind: .tspMatch); dismiss()
                        }
                        .foregroundStyle(Valor.red)
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }

    private var resultCard: some View {
        VStack(spacing: 4) {
            Text("AGENCY MATCH  ·  \(matchPercent.formatted(.number.precision(.fractionLength(0...1))))%")
                .font(.valorFont(12, weight: .heavy)).foregroundStyle(Valor.green).tracking(1.2)
            Text("\(MoneyText.usd(annualMatchCents)) / year")
                .font(.valorFont(34, weight: .black)).foregroundStyle(Valor.textPrimary)
            Text(contribution < 5 ? "Contribute 5% to collect the full match"
                                  : "You're collecting the full match 🎉")
                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(RoundedRectangle(cornerRadius: 18).fill(Valor.green.opacity(0.06)))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.green.opacity(0.25)))
    }

    private var saveBar: some View {
        VStack {
            Spacer()
            Button {
                store.save(TrackedBenefitEntry(
                    kind: .tspMatch,
                    annualValueCents: annualMatchCents,
                    detail: "\(matchPercent.formatted(.number.precision(.fractionLength(0...1))))% match on \(MoneyText.usd(basePayCents))",
                    annualBasePayCents: basePayCents,
                    contributionPercent: contribution))
                Haptics.success()
                dismiss()
            } label: {
                Text(basePayCents == 0 ? "Enter your base pay" : "Track \(MoneyText.usd(annualMatchCents)) / year")
                    .font(.valorButton(17)).foregroundStyle(.white)
                    .frame(maxWidth: .infinity).padding(.vertical, 16)
                    .background(RoundedRectangle(cornerRadius: 16)
                        .fill(basePayCents == 0 ? Valor.textTertiary : Valor.blue))
            }
            .disabled(basePayCents == 0)
            .padding(.horizontal, 20).padding(.bottom, 12)
        }
    }
}
