//
//  AllTransactionsView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct AllTransactionsView: View {
    let items: [BudgetItem]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(items) { item in
                    TransactionRowView(item: item)
                }
            }
            .padding(16)
        }
        .overlay {
            if items.isEmpty {
                ContentUnavailableView(
                    "No transactions yet",
                    systemImage: "tray",
                    description: Text("Budget items you add will show up here.")
                )
            }
        }
        .background(Color.backgroundLight)
        .navigationTitle("All Transactions")
        .inlineNavigationTitle()
    }
}

#Preview {
    NavigationStack {
        AllTransactionsView(items: BudgetItem.samples)
    }
}
