//
//  BudgetItem.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation
import SwiftyJSON

struct BudgetItem: Identifiable, Hashable, Encodable {
    var id: UUID = UUID()
    var name: String = ""
    var category: BudgetCategory = .foodAndBeverage
    var amount: Double = 0
    var date: Date = .now

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

    /// Dates are stored as seconds since 1970.
    init(with json: JSON) {
        self.id = UUID(uuidString: json["id"].stringValue) ?? UUID()
        self.name = json["name"].stringValue
        self.category = BudgetCategory(with: json["category"])
        self.amount = json["amount"].doubleValue
        self.date = Date(timeIntervalSince1970: json["date"].doubleValue)
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
