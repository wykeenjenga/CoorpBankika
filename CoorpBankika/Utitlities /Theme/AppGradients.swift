//
//  AppGradients.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

// Colours live in Resources/Assets.xcassets/Colors; these just combine them.
extension LinearGradient {
    @MainActor static let brand = LinearGradient(
        colors: [.gradientStart, .gradientEnd],
        startPoint: .topLeading,
        endPoint: .trailing
    )

    @MainActor static let success = LinearGradient(
        colors: [.successStart, .successEnd],
        startPoint: .top,
        endPoint: .bottom
    )
}
