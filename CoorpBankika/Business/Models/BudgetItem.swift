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
