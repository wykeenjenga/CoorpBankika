//
//  BudgetItem.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation
import SwiftyJSON

struct BudgetItem: Identifiable, Hashable, JSONModel {
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

    // MARK: - JSON

    /// Dates are stored as seconds since 1970.
    init(from json: JSON) throws {
        guard let id = UUID(uuidString: try json.requiredString("id")) else {
            throw JSONModelError.invalid(field: "id")
        }

        try self.init(
            id: id,
            name: json.requiredString("name"),
            category: BudgetCategory(from: json["category"]),
            amount: json.requiredDouble("amount"),
            date: Date(timeIntervalSince1970: json.requiredDouble("date"))
        )
    }

    var json: JSON {
        [
            "id": id.uuidString,
            "name": name,
            "category": category.json,
            "amount": amount,
            "date": date.timeIntervalSince1970
        ]
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
