//
//  CategoryLegendRowView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct CategoryLegendRowView: View {
    let spend: CategorySpend

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(spend.category.color)
                .frame(width: 12, height: 12)

            Text(spend.category.title)
                .foregroundStyle(Color.brandSecondary)

            Spacer(minLength: 8)

            Text("Ksh. \(spend.amount.oneDecimalString)")
                .foregroundStyle(Color.brandSecondary)
                .monospacedDigit()
        }
        .font(.system(size: 15))
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    CategoryLegendRowView(spend: CategorySpend(category: .foodAndBeverage, amount: 7000))
        .padding()
}
