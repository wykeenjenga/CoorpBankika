//
//  SpendBreakdownBarView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

/// Horizontal stacked bar showing each category's share of the month's spend.
/// Stays empty when nothing has been spent yet.
struct SpendBreakdownBarView: View {
    let segments: [CategorySpend]

    private var visibleSegments: [CategorySpend] {
        segments.filter { $0.amount > 0 }
    }

    private var total: Double {
        visibleSegments.reduce(0) { $0 + $1.amount }
    }

    var body: some View {
        GeometryReader { proxy in
            HStack(spacing: 0) {
                ForEach(visibleSegments) { segment in
                    Rectangle()
                        .fill(segment.category.color)
                        .frame(width: proxy.size.width * segment.amount / total)
                }
            }
        }
        .animation(.easeInOut(duration: 0.35), value: segments)
        .accessibilityHidden(true)
    }
}

#Preview {
    SpendBreakdownBarView(segments: [
        CategorySpend(category: .foodAndBeverage, amount: 7000),
        CategorySpend(category: .transportAndFuel, amount: 6000),
        CategorySpend(category: .clothing, amount: 3500),
        CategorySpend(category: .transactionFees, amount: 500)
    ])
    .frame(height: 22)
    .padding()
}
