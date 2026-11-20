//
//  TransactionRowView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct TransactionRowView: View {
    let item: BudgetItem

    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 10, style: .continuous)

        HStack(spacing: 12) {
            Image(item.category.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.brandSecondary)
                    .lineLimit(1)

                Text(item.date.transactionTimestamp)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.textSecondary)
            }

            Spacer(minLength: 8)

            VStack(alignment: .trailing, spacing: 4) {
                Text("Ksh. \(item.amount.oneDecimalString)")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.expenseRed)

                Text(item.category.title)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.textSecondary)
            }
        }
        .padding(.leading, 14)
        .padding(.trailing, 18)
        .padding(.vertical, 12)
        .background(Color.surface, in: shape)
        .overlay { shape.strokeBorder(Color.cardBorder) }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    VStack(spacing: 10) {
        ForEach(BudgetItem.samples.prefix(4)) { item in
            TransactionRowView(item: item)
        }
    }
    .padding()
}
