//
//  BudgetItemAddedView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import StoreKit
import SwiftUI

struct BudgetItemAddedView: View {
    let item: BudgetItem
    let onGoHome: () -> Void

    @Environment(\.requestReview) private var requestReview
    @State private var hasAppeared = false

    var body: some View {
        VStack(spacing: 0) {
            SuccessBadgeView(isAnimating: hasAppeared)

            Text("Budget Item Added")
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(Color.brandGreen)
                .padding(.top, 8)

            Text("Budget item has been added successfully.")
                .font(.system(size: 13))
                .foregroundStyle(Color.textSecondary)
                .padding(.top, 6)

            Rectangle()
                .fill(Color.cardBorder)
                .frame(height: 1)
                .padding(.top, 36)

            VStack(spacing: 14) {
                SummaryRowView(title: "Budget Item Name", value: item.name)
                SummaryRowView(
                    title: "Amount",
                    value: "Ksh \(item.amount.plainAmountString)",
                    valueColor: .brandPrimary
                )
                SummaryRowView(title: "Date", value: item.date.dayMonthYear)
            }
            .padding(.top, 22)

            Spacer(minLength: 32)

            VStack(spacing: 10) {
                Button("Go back to Home", action: onGoHome)
                    .buttonStyle(.filled(.brandGreen))

                Button("Rate your Experience") {
                    requestReview()
                }
                .buttonStyle(.outlined)
            }
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.surface)
        .navigationBarBackButtonHidden(true)
        .hidesNavigationBar()
        .sensoryFeedback(.success, trigger: hasAppeared)
        .onAppear {
            withAnimation(.spring(duration: 0.6, bounce: 0.35)) {
                hasAppeared = true
            }
        }
    }
}

#Preview {
    NavigationStack {
        BudgetItemAddedView(
            item: BudgetItem(name: "KFC Chicken", category: .foodAndBeverage, amount: 2000),
            onGoHome: {}
        )
    }
}
