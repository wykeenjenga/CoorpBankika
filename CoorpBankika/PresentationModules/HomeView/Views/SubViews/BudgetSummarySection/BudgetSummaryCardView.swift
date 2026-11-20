//
//  BudgetSummaryCardView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct BudgetSummaryCardView: View {
    let remainingBudget: Double

    private var isOverBudget: Bool { remainingBudget < 0 }

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(abs(remainingBudget).oneDecimalString)
                    .font(.system(size: 44, weight: .bold))
                    .contentTransition(.numericText(value: remainingBudget))

                Text("Ksh.")
                    .font(.system(size: 16, weight: .bold))
            }
            .lineLimit(1)
            .minimumScaleFactor(0.5)

            Text(isOverBudget ? "over your monthly budget" : "remaining on your monthly budget")
                .font(.system(size: 17))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(LinearGradient.brand, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .animation(.snappy, value: remainingBudget)
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    VStack(spacing: 20) {
        BudgetSummaryCardView(remainingBudget: 200_000)
    }
    .padding()
}
