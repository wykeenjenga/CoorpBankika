//
//  AppButtonStyles.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    var background: Color
    var foreground: Color

    func makeBody(configuration: Configuration) -> some View {
        FilledButton(configuration: configuration, background: background, foreground: foreground)
    }

    private struct FilledButton: View {
        let configuration: Configuration
        let background: Color
        let foreground: Color

        @Environment(\.isEnabled) private var isEnabled

        var body: some View {
            configuration.label
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(foreground)
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(background, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .contentShape(Rectangle())
                .opacity(isEnabled ? 1 : 0.5)
                .opacity(configuration.isPressed ? 0.85 : 1)
        }
    }
}

struct OutlinedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let shape = RoundedRectangle(cornerRadius: 8, style: .continuous)

        configuration.label
            .font(.system(size: 15, weight: .medium))
            .foregroundStyle(Color.brandGreen)
            .frame(maxWidth: .infinity, minHeight: 48)
            .background(Color.surface, in: shape)
            .overlay { shape.strokeBorder(Color.fieldBorder) }
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

extension ButtonStyle where Self == FilledButtonStyle {
    static func filled(_ background: Color, foreground: Color = .white) -> FilledButtonStyle {
        FilledButtonStyle(background: background, foreground: foreground)
    }
}

extension ButtonStyle where Self == OutlinedButtonStyle {
    static var outlined: OutlinedButtonStyle { OutlinedButtonStyle() }
}
