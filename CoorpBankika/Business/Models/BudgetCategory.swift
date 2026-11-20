//
//  BudgetCategory.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

enum BudgetCategory: String, CaseIterable, Identifiable, Codable {
    case foodAndBeverage
    case transportAndFuel
    case clothing
    case transactionFees

    var id: String { rawValue }

    var title: String {
        switch self {
        case .foodAndBeverage: "Food & Beverage"
        case .transportAndFuel: "Transport & Fuel"
        case .clothing: "Clothing"
        case .transactionFees: "Transaction Fees"
        }
    }

    var color: Color {
        switch self {
        case .foodAndBeverage: .categoryFood
        case .transportAndFuel: .categoryTransport
        case .clothing: .categoryClothing
        case .transactionFees: .categoryFees
        }
    }

    /// Merchant logo shown next to items in this category.
    var icon: ImageResource {
        switch self {
        case .foodAndBeverage: .kfc
        case .transportAndFuel: .total
        case .clothing: .naivas
        case .transactionFees: .paul
        }
    }
}
