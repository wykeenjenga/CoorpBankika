//
//  SummaryRowView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct SummaryRowView: View {
    let title: String
    let value: String
    var valueColor: Color = .brandSecondary

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 12) {
            Text(title)
                .font(.system(size: 13))
                .foregroundStyle(Color.textSecondary)

            Spacer(minLength: 8)

            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(valueColor)
                .multilineTextAlignment(.trailing)
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    VStack(spacing: 14) {
        SummaryRowView(title: "Budget Item Name", value: "KFC Chicken")
        SummaryRowView(title: "Amount", value: "Ksh 2000", valueColor: .brandPrimary)
        SummaryRowView(title: "Date", value: "27 November 2024")
    }
    .padding()
}
