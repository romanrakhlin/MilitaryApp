//
//  RatingCalculatorSheet.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// The disability rating calculator tool: stack individual ratings, see the
/// "VA math" combined result and estimated pay, and save calculations to
/// compare later.
struct RatingCalculatorSheet: View {
    @ObservedObject var store: HomeStore
    @Environment(\.dismiss) private var dismiss

    @State private var ratings: [Int] = []
    @State private var saveName = ""

    private var combined: CombinedRating { store.combine(ratings) }

    var body: some View {
        NavigationStack {
            ZStack {
                ValorBackground(glow: false)
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Add each individual rating from your decision letter. VA math combines them against your remaining capacity — they don't simply add up.")
                            .font(.valorBody(14)).foregroundStyle(Valor.textSecondary)

                        addGrid
                        if !ratings.isEmpty { currentStack }
                        resultCard
                        if !ratings.isEmpty { saveRow }
                        if !store.savedRatings.isEmpty { savedSection }
                        Color.clear.frame(height: 24)
                    }
                    .padding(20)
                }
                .scrollIndicators(.hidden)
                .onTapGesture { dismissKeyboard() }
            }
            .navigationTitle("Rating Calculator")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }.foregroundStyle(Valor.blue)
                }
            }
        }
        .preferredColorScheme(.light)
    }

    // MARK: Add ratings

    private var addGrid: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("ADD A RATING")
                .font(.valorFont(12, weight: .heavy))
                .foregroundStyle(Valor.textTertiary).tracking(1)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 56), spacing: 8)], spacing: 8) {
                ForEach(Array(stride(from: 10, through: 100, by: 10)), id: \.self) { p in
                    Button {
                        Haptics.selection()
                        withAnimation(.easeInOut) { ratings.append(p) }
                    } label: {
                        Text("\(p)")
                            .font(.valorFont(15, weight: .bold)).foregroundStyle(Valor.blue)
                            .frame(maxWidth: .infinity).padding(.vertical, 10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Valor.blue.opacity(0.08)))
                            .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(Valor.blue.opacity(0.25)))
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
        }
    }

    private var currentStack: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("YOUR RATINGS")
                    .font(.valorFont(12, weight: .heavy))
                    .foregroundStyle(Valor.textTertiary).tracking(1)
                Spacer()
                Button("Clear") { withAnimation(.easeInOut) { ratings.removeAll() } }
                    .font(.valorFont(13, weight: .bold)).foregroundStyle(Valor.red)
            }
            FlowingChips(ratings: ratings) { index in
                withAnimation(.easeInOut) { _ = ratings.remove(at: index) }
            }
        }
    }

    // MARK: Result

    private var resultCard: some View {
        VStack(spacing: 10) {
            HStack(spacing: 0) {
                statColumn(title: "EXACT",
                           value: ratings.isEmpty ? "—" : combined.exactPercent.formatted(.number.precision(.fractionLength(1))) + "%")
                Divider().frame(height: 44).overlay(Valor.cardStroke)
                statColumn(title: "COMBINED",
                           value: ratings.isEmpty ? "—" : "\(combined.roundedPercent)%", emphasized: true)
                Divider().frame(height: 44).overlay(Valor.cardStroke)
                statColumn(title: "EST. MONTHLY",
                           value: ratings.isEmpty ? "—" : MoneyText.usd(combined.monthlyCents))
            }
            Text("Rounded to the nearest 10%. Pay is the 2025 rate, veteran with no dependents.")
                .font(.valorBody(11)).foregroundStyle(Valor.textTertiary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 18).padding(.horizontal, 12)
        .background(RoundedRectangle(cornerRadius: 18).fill(Valor.blue.opacity(0.05)))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.blue.opacity(0.25)))
    }

    private func statColumn(title: String, value: String, emphasized: Bool = false) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.valorFont(10, weight: .heavy))
                .foregroundStyle(Valor.textTertiary).tracking(1)
            Text(value)
                .font(.valorFont(emphasized ? 26 : 19, weight: .black))
                .foregroundStyle(emphasized ? Valor.blue : Valor.textPrimary)
                .minimumScaleFactor(0.6).lineLimit(1)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: Save + saved list

    private var saveRow: some View {
        HStack(spacing: 10) {
            TextField("Name this calculation", text: $saveName)
                .font(.valorBody(15)).foregroundStyle(Valor.textPrimary)
                .padding(.horizontal, 14).padding(.vertical, 12)
                .background(RoundedRectangle(cornerRadius: 13).fill(Valor.card.opacity(0.5)))
                .overlay(RoundedRectangle(cornerRadius: 13).strokeBorder(Valor.cardStroke))
            Button {
                let name = saveName.trimmingCharacters(in: .whitespaces)
                store.saveRating(name: name.isEmpty ? "Scenario \(store.savedRatings.count + 1)" : name,
                                 ratings: ratings)
                saveName = ""
                Haptics.success()
                dismissKeyboard()
            } label: {
                Text("Save")
                    .font(.valorButton(15)).foregroundStyle(.white)
                    .padding(.horizontal, 20).padding(.vertical, 12)
                    .background(RoundedRectangle(cornerRadius: 13).fill(Valor.blue))
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }

    private var savedSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("SAVED CALCULATIONS")
                .font(.valorFont(12, weight: .heavy))
                .foregroundStyle(Valor.textTertiary).tracking(1)
            VStack(spacing: 8) {
                ForEach(store.savedRatings) { saved in
                    savedRow(saved)
                }
            }
        }
    }

    private func savedRow(_ saved: SavedRating) -> some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 3) {
                Text(saved.name).font(.valorButton(15)).foregroundStyle(Valor.textPrimary)
                Text(saved.ratings.map { "\($0)%" }.joined(separator: " + "))
                    .font(.valorBody(12)).foregroundStyle(Valor.textSecondary)
                    .lineLimit(1)
            }
            Spacer(minLength: 8)
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(saved.roundedPercent)%")
                    .font(.valorFont(17, weight: .black)).foregroundStyle(Valor.blue)
                Text("\(MoneyText.usd(saved.monthlyCents))/mo")
                    .font(.valorBody(11)).foregroundStyle(Valor.textTertiary)
            }
            Button {
                store.deleteRating(id: saved.id)
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: 14)).foregroundStyle(Valor.red)
                    .frame(width: 32, height: 32)
                    .background(Circle().fill(Valor.red.opacity(0.1)))
            }
        }
        .padding(12)
        .background(RoundedRectangle(cornerRadius: 14).fill(Valor.card.opacity(0.5)))
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Valor.cardStroke))
        .onTapGesture {
            withAnimation(.easeInOut) { ratings = saved.ratings }
            Haptics.selection()
        }
    }
}

/// Removable chips for the ratings currently in the calculator.
private struct FlowingChips: View {
    let ratings: [Int]
    let onRemove: (Int) -> Void

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 76), spacing: 8)], spacing: 8) {
            ForEach(Array(ratings.enumerated()), id: \.offset) { index, rating in
                Button { onRemove(index) } label: {
                    HStack(spacing: 5) {
                        Text("\(rating)%").font(.valorFont(14, weight: .bold))
                        Image(systemName: "xmark").font(.system(size: 9, weight: .bold))
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity).padding(.vertical, 9)
                    .background(Capsule().fill(Valor.blue))
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }
}
