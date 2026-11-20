//
//  OutlinedFieldModifier.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

/// The bordered box used by every input on the Add Budget form.
/// The border turns brand lime while the field is focused.
struct OutlinedFieldModifier: ViewModifier {
    var isFocused: Bool
    var borderColor: Color

    func body(content: Content) -> some View {
        let shape = RoundedRectangle(cornerRadius: 6, style: .continuous)

        content
            .font(.system(size: 15))
            .foregroundStyle(Color.brandSecondary)
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
            .background(Color.surface, in: shape)
            .overlay {
                shape.strokeBorder(
                    isFocused ? Color.brandPrimary : borderColor,
                    lineWidth: isFocused ? 1.5 : 1
                )
            }
            .animation(.easeOut(duration: 0.15), value: isFocused)
    }
}

extension View {
    func outlinedField(isFocused: Bool = false, borderColor: Color = .fieldBorder) -> some View {
        modifier(OutlinedFieldModifier(isFocused: isFocused, borderColor: borderColor))
    }
}
