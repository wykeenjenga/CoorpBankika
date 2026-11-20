//
//  View+Platform.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

// The target also builds for macOS, which has no navigation bar or
// on-screen keyboard, so these wrap the iOS-only modifiers.
extension View {
    @ViewBuilder
    func hidesNavigationBar() -> some View {
        #if canImport(UIKit)
        toolbar(.hidden, for: .navigationBar)
        #else
        self
        #endif
    }

    @ViewBuilder
    func inlineNavigationTitle() -> some View {
        #if canImport(UIKit)
        navigationBarTitleDisplayMode(.inline)
        #else
        self
        #endif
    }

    @ViewBuilder
    func decimalKeyboard() -> some View {
        #if canImport(UIKit)
        keyboardType(.decimalPad)
        #else
        self
        #endif
    }
}
