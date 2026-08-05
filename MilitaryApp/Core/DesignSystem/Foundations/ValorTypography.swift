//
//  ValorTypography.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI

extension Font {
    /// The app uses the native system typeface (SF Pro). This helper keeps a
    /// single entry point for brand type so sizes/weights stay consistent.
    static func valorFont(_ size: CGFloat, weight: Font.Weight = .regular,
                          relativeTo textStyle: Font.TextStyle = .body) -> Font {
        .system(size: size, weight: weight).leading(.standard)
    }

    /// Large heavy display titles used across onboarding.
    static func valorTitle(_ size: CGFloat = 40) -> Font {
        .valorFont(size, weight: .black, relativeTo: .largeTitle)
    }
    static func valorHeadline(_ size: CGFloat = 22) -> Font {
        .valorFont(size, weight: .bold, relativeTo: .title2)
    }
    static func valorBody(_ size: CGFloat = 17) -> Font {
        .valorFont(size, weight: .regular, relativeTo: .body)
    }
    static func valorButton(_ size: CGFloat = 18) -> Font {
        .valorFont(size, weight: .bold, relativeTo: .headline)
    }
}
