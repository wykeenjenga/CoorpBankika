//
//  CategorySpend.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation

/// How much went to one category in the selected month.
struct CategorySpend: Identifiable, Equatable {
    let category: BudgetCategory
    let amount: Double

    var id: BudgetCategory { category }
}
