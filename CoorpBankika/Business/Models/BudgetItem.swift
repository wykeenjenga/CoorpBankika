//
//  BudgetItem.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation

struct BudgetItem: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    let category: BudgetCategory
    let amount: Double
    let date: Date

    init(
        id: UUID = UUID(),
        name: String,
        category: BudgetCategory,
        amount: Double,
        date: Date = .now
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
        self.date = date
    }
}

extension BudgetItem {
    /// Mirrors the populated home screen from the design. Used by previews.
    static var samples: [BudgetItem] {
        let now = Date.now
        func minutesAgo(_ minutes: Double) -> Date {
            now.addingTimeInterval(-minutes * 60)
        }

        return [
            BudgetItem(name: "KFC Chicken", category: .foodAndBeverage, amount: 2000, date: minutesAgo(1)),
            BudgetItem(name: "mitumba", category: .clothing, amount: 1500, date: minutesAgo(2)),
            BudgetItem(name: "Train", category: .transportAndFuel, amount: 6000, date: minutesAgo(7)),
            BudgetItem(name: "all Fees", category: .transactionFees, amount: 500, date: minutesAgo(8)),
            BudgetItem(name: "Weekly groceries", category: .foodAndBeverage, amount: 5000, date: minutesAgo(30)),
            BudgetItem(name: "Rain jacket", category: .clothing, amount: 2000, date: minutesAgo(45))
        ]
    }
}
