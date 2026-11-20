//
//  TotalSpendSectionView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct TotalSpendSectionView: View {
    let totalSpend: Double
    let categorySpends: [CategorySpend]
    @Binding var selectedMonth: Date
    let monthOptions: [Date]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Spend this Month")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.textSecondary)

                    Text("Ksh \(totalSpend.oneDecimalString)")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.brandSecondary)
                        .contentTransition(.numericText(value: totalSpend))
                }

                Spacer(minLength: 12)

                MonthPickerView(selection: $selectedMonth, options: monthOptions)
            }

            SpendBreakdownBarView(segments: categorySpends)
                .frame(height: 22)
                .padding(.top, 18)

            VStack(spacing: 14) {
                ForEach(categorySpends) { spend in
                    CategoryLegendRowView(spend: spend)
                }
            }
            .padding(.top, 22)
        }
        .padding(.horizontal, 16)
        .padding(.top, 18)
        .padding(.bottom, 20)
        .background(Color.surface)
        .animation(.snappy, value: totalSpend)
    }
}

#Preview {
    @Previewable @State var month = Date.now
    TotalSpendSectionView(
        totalSpend: 17_000,
        categorySpends: [
            CategorySpend(category: .foodAndBeverage, amount: 7000),
            CategorySpend(category: .transportAndFuel, amount: 6000),
            CategorySpend(category: .clothing, amount: 3500),
            CategorySpend(category: .transactionFees, amount: 500)
        ],
        selectedMonth: $month,
        monthOptions: [month]
    )
}
