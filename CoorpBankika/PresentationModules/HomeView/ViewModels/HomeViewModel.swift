//
//  HomeViewModel.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation
import Observation

@Observable
final class HomeViewModel {
    let userName: String
    let monthOptions: [Date]
    var selectedMonth: Date

    private let store: BudgetStore
    private let recentItemsLimit = 5

    init(
        store: BudgetStore,
        userName: String = "John Doe",
        calendar: Calendar = .current,
        now: Date = .now
    ) {
        self.store = store
        self.userName = userName

        let startOfYear = calendar.dateInterval(of: .year, for: now)?.start ?? now
        self.monthOptions = (0..<12).compactMap {
            calendar.date(byAdding: .month, value: $0, to: startOfYear)
        }
        self.selectedMonth = calendar.dateInterval(of: .month, for: now)?.start ?? now
    }

    /// The card always reflects the current month, whatever month is picked below it.
    var remainingBudget: Double {
        store.remainingBudget(inMonthOf: .now)
    }

    var totalSpend: Double {
        store.totalSpend(inMonthOf: selectedMonth)
    }

    var categorySpends: [CategorySpend] {
        BudgetCategory.allCases.map {
            CategorySpend(category: $0, amount: store.spend(for: $0, inMonthOf: selectedMonth))
        }
    }

    var recentItems: [BudgetItem] {
        Array(store.itemsNewestFirst.prefix(recentItemsLimit))
    }

    var allItems: [BudgetItem] {
        store.itemsNewestFirst
    }
}
