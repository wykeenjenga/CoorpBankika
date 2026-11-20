//
//  BudgetCategory.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI
import SwiftyJSON

enum BudgetCategory: String, CaseIterable, Identifiable, JSONModel {
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

    // MARK: - JSON

    /// Categories travel as their raw value, e.g. `"foodAndBeverage"`.
    init(from json: JSON) throws {
        guard json.exists() else { throw JSONModelError.missing(field: "category") }
        guard let rawValue = json.string, let category = BudgetCategory(rawValue: rawValue) else {
            throw JSONModelError.invalid(field: "category")
        }
        self = category
    }

    var json: JSON {
        JSON(rawValue)
    }
}
