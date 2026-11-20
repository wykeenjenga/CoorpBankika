//
//  AppTab.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

enum AppTab: Hashable, CaseIterable {
    case home
    case budgets
    case add
    case reports
    case account

    var title: String {
        switch self {
        case .home: "Home"
        case .budgets: "Budgets"
        case .add: "Add"
        case .reports: "Reports"
        case .account: "Acount"
        }
    }

    var icon: ImageResource {
        switch self {
        case .home: .icHome
        case .budgets: .icBudgets
        case .add: .addButton
        case .reports: .icReports
        case .account: .icPerson
        }
    }
}
