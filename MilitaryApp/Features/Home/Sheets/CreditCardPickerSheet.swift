//
//  CreditCardPickerSheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// Setup sheet for the Credit Cards benefit: pick the premium cards you hold
/// and track their MLA/SCRA-waived annual fees.
struct CreditCardPickerSheet: View {
    @ObservedObject var store: HomeStore
    @Environment(\.dismiss) private var dismiss

    @State private var selectedIDs: Set<String>

    init(store: HomeStore) {
        self.store = store
        _selectedIDs = State(initialValue: Set(store.entry(for: .creditCards)?.cardIDs ?? []))
    }

    private var waivedCents: Int {
        store.creditCards.filter { selectedIDs.contains($0.id) }
            .reduce(0) { $0 + $1.annualFeeCents }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Active-duty members (and spouses) get annual fees waived on premium cards under MLA/SCRA. Select the cards you hold.")
                            .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)

                        VStack(spacing: 10) {
                            ForEach(store.creditCards) { card in
                                cardRow(card)
                            }
                        }
                        Color.clear.frame(height: 90)
                    }
                    .padding(20)
                }
                .scrollIndicators(.hidden)

                saveBar
            }
            .navigationTitle("Credit Cards")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }.foregroundStyle(Valor.textSecondary)
                }
                if store.entry(for: .creditCards) != nil {
                    ToolbarItem(placement: .destructiveAction) {
                        Button("Remove") {
                            store.removeEntry(kind: .creditCards); dismiss()
                        }
                        .foregroundStyle(Valor.red)
                    }
                }
            }
        }
        .preferredColorScheme(.light)
    }

    private func cardRow(_ card: MilitaryCreditCard) -> some View {
        let isOn = selectedIDs.contains(card.id)
        return Button {
            Haptics.selection()
            if isOn { selectedIDs.remove(card.id) } else { selectedIDs.insert(card.id) }
        } label: {
            HStack(spacing: 12) {
                Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundStyle(isOn ? Valor.blue : Valor.textTertiary)
                VStack(alignment: .leading, spacing: 2) {
                    Text(card.name).font(.valorButton(15)).foregroundStyle(Valor.textPrimary)
                    Text("\(card.issuer) · \(card.blurb)")
                        .font(.valorBody(12)).foregroundStyle(Valor.textSecondary)
                        .lineLimit(1)
                }
                Spacer(minLength: 8)
                Text(MoneyText.usd(card.annualFeeCents))
                    .font(.valorFont(15, weight: .black))
                    .foregroundStyle(isOn ? Valor.blue : Valor.textPrimary)
            }
            .padding(14)
            .background(RoundedRectangle(cornerRadius: 16).fill(isOn ? Valor.blue.opacity(0.06) : Valor.card.opacity(0.5)))
            .overlay(RoundedRectangle(cornerRadius: 16)
                .strokeBorder(isOn ? Valor.blue.opacity(0.4) : Valor.cardStroke))
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private var saveBar: some View {
        VStack {
            Spacer()
            Button {
                let ids = Array(selectedIDs)
                store.save(TrackedBenefitEntry(
                    kind: .creditCards,
                    annualValueCents: waivedCents,
                    detail: "\(ids.count) card\(ids.count == 1 ? "" : "s") · fees waived",
                    cardIDs: ids))
                Haptics.success()
                dismiss()
            } label: {
                Text(selectedIDs.isEmpty ? "Select your cards" : "Track \(MoneyText.usd(waivedCents)) in waived fees")
                    .font(.valorButton(17)).foregroundStyle(.white)
                    .frame(maxWidth: .infinity).padding(.vertical, 16)
                    .background(RoundedRectangle(cornerRadius: 16)
                        .fill(selectedIDs.isEmpty ? Valor.textTertiary : Valor.blue))
            }
            .disabled(selectedIDs.isEmpty)
            .padding(.horizontal, 20).padding(.bottom, 12)
        }
    }
}
