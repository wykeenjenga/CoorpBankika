//
//  CategorySpend.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation
import Combine
import SwiftyJSON

/// How much went to one category in the selected month or so
struct CategorySpend: Identifiable, Equatable, JSONModel {
    let category: BudgetCategory
    var amount: Double

    /// A closure for our ide 
    var id: BudgetCategory { category }
    
    // Writing any init removes Swift's free memberwise one, so this has to set every property.
    init(category: BudgetCategory, amount: Double) {
        self.category = category
        self.amount = amount
    }

    // MARK: - JSON

    init(from json: JSON) throws {
        try self.init(
            category: BudgetCategory(from: json["category"]),
            amount: json.requiredDouble("amount")
        )
    }

    var json: JSON {
        ["category": category.json, "amount": amount]
    }
}
