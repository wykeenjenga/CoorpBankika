//
//  HomeViewModel.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var selectedMonth: Date
    @Published private(set) var remainingBudget: Double = 0
    @Published private(set) var totalSpend: Double = 0
    @Published private(set) var categorySpends: [CategorySpend] = []
    @Published private(set) var recentItems: [BudgetItem] = []
    @Published private(set) var allItems: [BudgetItem] = []

    let userName: String
    let monthOptions: [Date]

    private let monthlyBudget: Double
    private let calendar: Calendar
    private let recentItemsLimit = 5
    private var cancellables = Set<AnyCancellable>()

    init(
        store: BudgetStore,
        userName: String = "John Doe",
        calendar: Calendar = .current,
        now: Date = .now
    ) {
        self.userName = userName
        self.monthlyBudget = store.monthlyBudget
        self.calendar = calendar

        let startOfYear = calendar.dateInterval(of: .year, for: now)?.start ?? now
        self.monthOptions = (0..<12).compactMap {
            calendar.date(byAdding: .month, value: $0, to: startOfYear)
        }
        self.selectedMonth = calendar.dateInterval(of: .month, for: now)?.start ?? now

        // @Published fires before the new value is stored, so work from what the publishers send.
        store.$items
            .combineLatest($selectedMonth)
            .sink { [weak self] items, month in
                self?.refresh(items: items, selectedMonth: month)
            }
            .store(in: &cancellables)
    }

    private func refresh(items: [BudgetItem], selectedMonth: Date) {
        let newestFirst = items.sorted { $0.date > $1.date }
        let pickedMonth = filter(items, toMonthOf: selectedMonth)

        // The card always reflects the current month, whatever month is picked below it.
        remainingBudget = monthlyBudget - total(of: filter(items, toMonthOf: .now))
        totalSpend = total(of: pickedMonth)
        categorySpends = BudgetCategory.allCases.map { category in
            CategorySpend(category: category, amount: total(of: pickedMonth.filter { $0.category == category }))
        }
        recentItems = Array(newestFirst.prefix(recentItemsLimit))
        allItems = newestFirst
    }

    private func filter(_ items: [BudgetItem], toMonthOf date: Date) -> [BudgetItem] {
        items.filter { calendar.isDate($0.date, equalTo: date, toGranularity: .month) }
    }

    private func total(of items: [BudgetItem]) -> Double {
        items.reduce(0) { $0 + $1.amount }
    }
}
