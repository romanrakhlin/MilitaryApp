//
//  DisabilitySetupSheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Setup sheet for the VA Disability benefit: pick your combined rating and
/// track the estimated annual compensation.
struct DisabilitySetupSheet: View {
    @ObservedObject var store: HomeStore
    @Environment(\.dismiss) private var dismiss

    @State private var percent: Int

    init(store: HomeStore) {
        self.store = store
        _percent = State(initialValue: store.entry(for: .vaDisability)?.disabilityPercent ?? 50)
    }

    private var monthlyCents: Int { store.combine([percent]).monthlyCents }

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Select your combined VA disability rating. Compensation is the 2025 rate for a veteran with no dependents.")
                            .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)

                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 64), spacing: 10)], spacing: 10) {
                            ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) { p in
                                percentChip(p)
                            }
                        }

                        resultCard
                        Color.clear.frame(height: 90)
                    }
                    .padding(20)
                }
                .scrollIndicators(.hidden)

                saveBar
            }
            .navigationTitle("VA Disability")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }.foregroundStyle(Valor.textSecondary)
                }
                if store.entry(for: .vaDisability) != nil {
                    ToolbarItem(placement: .destructiveAction) {
                        Button("Remove") {
                            store.removeEntry(kind: .vaDisability); dismiss()
                        }
                        .foregroundStyle(Valor.red)
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }

    private func percentChip(_ p: Int) -> some View {
        Button {
            Haptics.selection(); percent = p
        } label: {
            Text("\(p)%")
                .font(.valorFont(16, weight: .bold))
                .foregroundStyle(percent == p ? .white : Valor.textPrimary)
                .frame(maxWidth: .infinity).padding(.vertical, 12)
                .background(RoundedRectangle(cornerRadius: 12)
                    .fill(percent == p ? Valor.blue : Valor.card))
                .overlay(RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(percent == p ? Valor.blue : Valor.cardStroke))
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private var resultCard: some View {
        VStack(spacing: 4) {
            Text("ESTIMATED COMPENSATION")
                .font(.valorFont(12, weight: .heavy)).foregroundStyle(Valor.red).tracking(1.2)
            Text("\(MoneyText.usd(monthlyCents)) / month")
                .font(.valorFont(34, weight: .black)).foregroundStyle(Valor.textPrimary)
            Text("\(MoneyText.usd(monthlyCents * 12)) per year, tax-free")
                .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(RoundedRectangle(cornerRadius: 18).fill(Valor.red.opacity(0.06)))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.red.opacity(0.25)))
    }

    private var saveBar: some View {
        VStack {
            Spacer()
            Button {
                store.save(TrackedBenefitEntry(
                    kind: .vaDisability,
                    annualValueCents: monthlyCents * 12,
                    detail: "\(percent)% rating · \(MoneyText.usd(monthlyCents))/mo",
                    disabilityPercent: percent))
                Haptics.success()
                dismiss()
            } label: {
                Text("Track \(MoneyText.usd(monthlyCents * 12)) / year")
                    .font(.valorButton(17)).foregroundStyle(.white)
                    .frame(maxWidth: .infinity).padding(.vertical, 16)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Valor.blue))
            }
            .padding(.horizontal, 20).padding(.bottom, 12)
        }
    }
}
