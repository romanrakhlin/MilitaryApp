//
//  DiscountPreviewScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A locked "discounts near you" teaser. Reaching this screen is where nearby
/// places first matter, so we request the system location permission here (once)
/// as the screen appears.
struct DiscountPreviewScreen: View {
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OBTitle(title: "There are 120+ military discounts within 10 miles of you.")
                .padding(.top, 8)

            ZStack {
                RoundedRectangle(cornerRadius: 20).fill(Valor.card.opacity(0.6))
                    .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Valor.cardStroke))
                // scattered pins
                ForEach(0..<6, id: \.self) { i in
                    Image(systemName: "mappin")
                        .foregroundStyle(i % 2 == 0 ? Valor.blue : Valor.red)
                        .offset(x: [-90, 70, -40, 30, -70, 60][i], y: [-40, -60, 20, 40, 60, 10][i])
                }
                VStack(spacing: 8) {
                    Image(systemName: "lock.fill").font(.system(size: 22))
                        .foregroundStyle(.white)
                        .frame(width: 56, height: 56)
                        .background(Circle().fill(Color.black.opacity(0.5)))
                    Text("Locked preview").font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                }
            }
            .frame(height: 260)
            Spacer()
            PrimaryButton(title: "See them all", action: onNext).padding(.bottom, 20)
        }
        .obPadding().padding(.top, 24)
        .onAppear { LocationManager.shared.requestWhenInUseIfNeeded() }
    }
}
