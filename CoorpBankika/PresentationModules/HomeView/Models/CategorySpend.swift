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
struct CategorySpend: Identifiable, Equatable, Encodable {
    var category: BudgetCategory = .foodAndBeverage
    var amount: Double = 0

    /// A closure for our ide 
    var id: BudgetCategory { category }
    
    init(category: BudgetCategory, amount: Double) {
        self.category = category
        self.amount = amount
    }

    init(with json: JSON) {
        self.category = BudgetCategory(with: json["category"])
        self.amount = json["amount"].doubleValue
    }
}
