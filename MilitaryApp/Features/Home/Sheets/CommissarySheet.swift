//
//  CommissarySheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Setup sheet for the Commissary benefit: monthly grocery spend → estimated
/// annual savings at ~25% vs. off-base prices.
struct CommissarySheet: View {
    @ObservedObject var store: HomeStore
    @Environment(\.dismiss) private var dismiss

    @State private var monthlyText: String

    private static let savingsRate = 0.25

    init(store: HomeStore) {
        self.store = store
        let cents = store.entry(for: .commissary)?.monthlyGroceryCents ?? 0
        _monthlyText = State(initialValue: cents == 0 ? "" : String(cents / 100))
    }

    private var monthlyCents: Int { (Int(monthlyText) ?? 0) * 100 }
    private var annualSavingsCents: Int {
        Int(Double(monthlyCents) * Self.savingsRate * 12)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Commissary prices average about 25% below off-base grocery stores. Enter what you spend on groceries each month.")
                            .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)

                        VStack(alignment: .leading, spacing: 8) {
                            Text("MONTHLY GROCERY SPEND")
                                .font(.valorFont(12, weight: .heavy))
                                .foregroundStyle(Valor.textTertiary).tracking(1)
                            HStack {
                                Text("$").font(.valorFont(20, weight: .bold)).foregroundStyle(Valor.textSecondary)
                                TextField("600", text: $monthlyText)
                                    .keyboardType(.numberPad)
                                    .font(.valorFont(20, weight: .bold))
                                    .foregroundStyle(Valor.textPrimary)
                            }
                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 14).fill(Valor.card.opacity(0.5)))
                            .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
                        }

                        VStack(spacing: 4) {
                            Text("ESTIMATED SAVINGS")
                                .font(.valorFont(12, weight: .heavy))
                                .foregroundStyle(Color.orange).tracking(1.2)
                            Text("\(MoneyText.usd(annualSavingsCents)) / year")
                                .font(.valorFont(34, weight: .black)).foregroundStyle(Valor.textPrimary)
                            Text("≈ 25% of \(MoneyText.usd(monthlyCents))/mo, shopping on base")
                                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(RoundedRectangle(cornerRadius: 18).fill(Color.orange.opacity(0.06)))
                        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Color.orange.opacity(0.25)))

                        Color.clear.frame(height: 90)
                    }
                    .padding(20)
                }
                .scrollIndicators(.hidden)
                .onTapGesture { dismissKeyboard() }

                saveBar
            }
            .navigationTitle("Commissary")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }.foregroundStyle(Valor.textSecondary)
                }
                if store.entry(for: .commissary) != nil {
                    ToolbarItem(placement: .destructiveAction) {
                        Button("Remove") {
                            store.removeEntry(kind: .commissary); dismiss()
                        }
                        .foregroundStyle(Valor.red)
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }

    private var saveBar: some View {
        VStack {
            Spacer()
            Button {
                store.save(TrackedBenefitEntry(
                    kind: .commissary,
                    annualValueCents: annualSavingsCents,
                    detail: "~25% of \(MoneyText.usd(monthlyCents))/mo groceries",
                    monthlyGroceryCents: monthlyCents))
                Haptics.success()
                dismiss()
            } label: {
                Text(monthlyCents == 0 ? "Enter your grocery spend" : "Track \(MoneyText.usd(annualSavingsCents)) / year")
                    .font(.valorButton(17)).foregroundStyle(.white)
                    .frame(maxWidth: .infinity).padding(.vertical, 16)
                    .background(RoundedRectangle(cornerRadius: 16)
                        .fill(monthlyCents == 0 ? Valor.textTertiary : Valor.blue))
            }
            .disabled(monthlyCents == 0)
            .padding(.horizontal, 20).padding(.bottom, 12)
        }
    }
}
