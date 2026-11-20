//
//  BudgetItem+Samples.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation

/// Sample items for Xcode previews only. They match the populated home screen in the design.
extension BudgetItem {
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
