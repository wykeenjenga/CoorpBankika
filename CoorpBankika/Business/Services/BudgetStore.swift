//
//  BudgetStore.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation
import Observation

/// Single source of truth for the user's budget items.
/// Items are saved to `UserDefaults` so they survive relaunches.
@Observable
final class BudgetStore {
    let monthlyBudget: Double
    private(set) var items: [BudgetItem]

    private let defaults: UserDefaults?
    private let calendar: Calendar

    private static let itemsKey = "budget.items"

    init(
        monthlyBudget: Double = 200_000,
        defaults: UserDefaults = .standard,
        calendar: Calendar = .current
    ) {
        self.monthlyBudget = monthlyBudget
        self.defaults = defaults
        self.calendar = calendar
        self.items = Self.loadItems(from: defaults)
    }

    /// In-memory store that never touches disk. Handy for previews and tests.
    init(
        items: [BudgetItem],
        monthlyBudget: Double = 200_000,
        calendar: Calendar = .current
    ) {
        self.monthlyBudget = monthlyBudget
        self.defaults = nil
        self.calendar = calendar
        self.items = items
    }

    var itemsNewestFirst: [BudgetItem] {
        items.sorted { $0.date > $1.date }
    }

    @discardableResult
    func addItem(
        named name: String,
        category: BudgetCategory,
        amount: Double,
        date: Date = .now
    ) -> BudgetItem {
        let item = BudgetItem(name: name, category: category, amount: amount, date: date)
        items.append(item)
        save()
        return item
    }

    func items(inMonthOf date: Date) -> [BudgetItem] {
        items.filter { calendar.isDate($0.date, equalTo: date, toGranularity: .month) }
    }

    func totalSpend(inMonthOf date: Date) -> Double {
        items(inMonthOf: date).reduce(0) { $0 + $1.amount }
    }

    func spend(for category: BudgetCategory, inMonthOf date: Date) -> Double {
        items(inMonthOf: date)
            .filter { $0.category == category }
            .reduce(0) { $0 + $1.amount }
    }

    func remainingBudget(inMonthOf date: Date) -> Double {
        monthlyBudget - totalSpend(inMonthOf: date)
    }

    // MARK: - Persistence

    private func save() {
        guard let defaults, let data = try? JSONEncoder().encode(items) else { return }
        defaults.set(data, forKey: Self.itemsKey)
    }

    private static func loadItems(from defaults: UserDefaults) -> [BudgetItem] {
        guard
            let data = defaults.data(forKey: itemsKey),
            let items = try? JSONDecoder().decode([BudgetItem].self, from: data)
        else { return [] }
        return items
    }
}
