//
//  ConfettiView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

/// Small burst of confetti that fans out from the centre when `isBursting` turns on.
struct ConfettiView: View {
    var isBursting: Bool

    private static let pieces = ConfettiPiece.burst(count: 56)

    var body: some View {
        ZStack {
            ForEach(Self.pieces) { piece in
                Capsule()
                    .fill(piece.color)
                    .frame(width: piece.length, height: piece.thickness)
                    .rotationEffect(piece.rotation)
                    .offset(isBursting ? piece.offset : .zero)
                    .opacity(isBursting ? 1 : 0)
            }
        }
        .accessibilityHidden(true)
    }
}

struct ConfettiPiece: Identifiable {
    let id: Int
    let color: Color
    let offset: CGSize
    let rotation: Angle
    let length: CGFloat
    let thickness: CGFloat

    private static let palette: [Color] = [
        .expenseRed,
        .categoryClothing,
        .brandPrimary,
        .categoryFees,
        .successStart,
        .categoryFood
    ]

    /// Seeded so the pattern looks the same every time the screen opens.
    static func burst(count: Int) -> [ConfettiPiece] {
        var generator = SeededGenerator(seed: 27)

        return (0..<count).map { index in
            let angle = Double.random(in: 0..<(2 * .pi), using: &generator)
            let distance = Double.random(in: 34...58, using: &generator)
            let isDot = Double.random(in: 0...1, using: &generator) < 0.3

            return ConfettiPiece(
                id: index,
                color: palette[index % palette.count],
                offset: CGSize(width: cos(angle) * distance * 1.1, height: sin(angle) * distance),
                rotation: .radians(Double.random(in: 0..<(2 * .pi), using: &generator)),
                length: isDot ? 2.5 : CGFloat.random(in: 4...9, using: &generator),
                thickness: isDot ? 2.5 : 1.6
            )
        }
    }
}

/// SplitMix64 – tiny, fast and good enough for decoration.
struct SeededGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        state = seed
    }

    mutating func next() -> UInt64 {
        state &+= 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        return z ^ (z >> 31)
    }
}

#Preview {
    ConfettiView(isBursting: true)
        .frame(width: 140, height: 120)
}
