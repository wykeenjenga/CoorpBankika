//
//  RecentTransactionsSectionView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct RecentTransactionsSectionView: View {
    let items: [BudgetItem]
    let onViewAll: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Recent Transactions")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(Color.brandSecondary)

                Spacer()

                Button(action: onViewAll) {
                    HStack(spacing: 8) {
                        Text("View All")
                        Image(systemName: "arrow.up.right.square")
                    }
                    .font(.system(size: 16))
                    .foregroundStyle(Color.brandPrimary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 16)
            .frame(height: 56)

            if !items.isEmpty {
                LazyVStack(spacing: 10) {
                    ForEach(items) { item in
                        TransactionRowView(item: item)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .background(Color.surface)
    }
}

#Preview {
    RecentTransactionsSectionView(items: BudgetItem.samples, onViewAll: {})
}
