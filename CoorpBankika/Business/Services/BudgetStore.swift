//
//  BudgetStore.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Combine
import Foundation
import SwiftyJSON

/// Single source of truth for the user's budget items.
/// Items are saved to `UserDefaults` so they survive relaunches.
@MainActor
final class BudgetStore: ObservableObject {
    @Published private(set) var items: [BudgetItem]

    let monthlyBudget: Double

    private let defaults: UserDefaults?

    private static let itemsKey = "budgetItems"

    init(monthlyBudget: Double = 200_000, defaults: UserDefaults = .standard) {
        self.monthlyBudget = monthlyBudget
        self.defaults = defaults
        self.items = Self.loadItems(from: defaults)
    }

    /// In-memory store that never touches disk. Handy for previews and tests.
    init(items: [BudgetItem], monthlyBudget: Double = 200_000) {
        self.monthlyBudget = monthlyBudget
        self.defaults = nil
        self.items = items
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

    // MARK: - Persistence

    private func save() {
        guard let defaults, let data = try? Self.encoder.encode(items) else { return }
        defaults.set(data, forKey: Self.itemsKey)
    }

    private static func loadItems(from defaults: UserDefaults) -> [BudgetItem] {
        guard
            let data = defaults.data(forKey: itemsKey),
            let json = try? JSON(data: data)
        else { return [] }
        return json.arrayValue.map { BudgetItem(with: $0) }
    }

    /// Dates go out as seconds since 1970, which is what `BudgetItem(with:)` reads back.
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }()
}
