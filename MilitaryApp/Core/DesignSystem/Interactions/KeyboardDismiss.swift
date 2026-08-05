//
//  KeyboardDismiss.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import UIKit

/// Resigns the first responder to dismiss the keyboard from anywhere.
@MainActor func dismissKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
}
