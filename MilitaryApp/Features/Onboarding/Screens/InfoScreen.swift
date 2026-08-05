//
//  InfoScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

/// A reusable centered title + body + continue screen, used for the closing
/// mission / made-in-America / data-privacy statements.
struct InfoScreen: View {
    let title: String
    let body_: String
    let buttonTitle: String
    let action: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Text(title)
                .font(.valorTitle(38)).foregroundStyle(Valor.textPrimary)
                .multilineTextAlignment(.center).obPadding()
            Text(body_)
                .font(.valorBody(18)).foregroundStyle(Valor.textSecondary)
                .multilineTextAlignment(.center).padding(.top, 14).obPadding()
            Spacer()
            PrimaryButton(title: buttonTitle, action: action).obPadding().padding(.bottom, 20)
        }
    }

    static func gettingStarted(onNext: @escaping () -> Void) -> InfoScreen {
        InfoScreen(title: "We're just getting started.",
                   body_: "Our goal is simple: keep building tools that help the military community claim everything you've earned. You're not a product. You're who we build for.",
                   buttonTitle: "Continue", action: onNext)
    }

    static func madeInAmerica(onNext: @escaping () -> Void) -> InfoScreen {
        InfoScreen(title: "Made in America. By people who get it.",
                   body_: "Every line of code is built right here in the U.S. and never shipped overseas. Your benefits deserve to be handled by people who actually understand the mission.",
                   buttonTitle: "Continue", action: onNext)
    }

    static func dataPrivacy(onNext: @escaping () -> Void) -> InfoScreen {
        InfoScreen(title: "Your data is yours. Full stop.",
                   body_: "We will never sell your information. Not to advertisers, not to data brokers, not to anyone. We make money when we build something worth paying for, not by selling you.",
                   buttonTitle: "Continue", action: onNext)
    }
}
