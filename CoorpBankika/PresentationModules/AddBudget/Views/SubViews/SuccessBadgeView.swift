//
//  SuccessBadgeView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct SuccessBadgeView: View {
    var isAnimating: Bool

    var body: some View {
        ZStack {
            ConfettiView(isBursting: isAnimating)

            Circle()
                .fill(LinearGradient.success)
                .frame(width: 60, height: 60)
                .overlay {
                    Image(systemName: "checkmark")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundStyle(.white)
                }
                .scaleEffect(isAnimating ? 1 : 0.4)
                .opacity(isAnimating ? 1 : 0)
        }
        .frame(width: 140, height: 120)
        .accessibilityHidden(true)
    }
}

#Preview {
    SuccessBadgeView(isAnimating: true)
}
