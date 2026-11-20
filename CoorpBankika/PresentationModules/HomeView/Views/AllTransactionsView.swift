//
//  AllTransactionsView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct AllTransactionsView: View {
    let items: [BudgetItem]

    @State private var searchText = ""

    /// Matches the item name or category, ignoring case and accents.
    private var filteredItems: [BudgetItem] {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        guard !query.isEmpty else { return items }
        return items.filter {
            $0.name.localizedStandardContains(query) || $0.category.title.localizedStandardContains(query)
        }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(filteredItems) { item in
                    TransactionRowView(item: item)
                }
            }
            .padding(16)
        }
        .scrollDismissesKeyboard(.immediately)
        .overlay {
            if items.isEmpty {
                ContentUnavailableView(
                    "No transactions yet",
                    systemImage: "tray",
                    description: Text("Budget items you add will show up here.")
                )
            } else if filteredItems.isEmpty {
                ContentUnavailableView.search(text: searchText)
            }
        }
        .searchable(text: $searchText, prompt: "Search by name or category")
        .padding(.top)
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
