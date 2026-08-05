//
//  TestimonialScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A member testimonial card.
struct TestimonialScreen: View {
    let onNext: () -> Void

    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Image(systemName: "quote.opening")
                    .font(.system(size: 34)).foregroundStyle(Valor.blue)
                Text("I had no idea how many benefits I had as a reservist. This app changed that completely.")
                    .font(.valorTitle(26)).foregroundStyle(Valor.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
                Text("— James, Army Reserve Staff Sergeant")
                    .font(.valorBody(16)).foregroundStyle(Valor.textSecondary)
            }
            .padding(26)
            .background(RoundedRectangle(cornerRadius: 22).fill(Valor.card.opacity(0.55)))
            .overlay(RoundedRectangle(cornerRadius: 22).strokeBorder(Valor.cardStroke))
            .obPadding()
            Spacer()
            PrimaryButton(title: "Continue", action: onNext).obPadding().padding(.bottom, 20)
        }
    }
}
