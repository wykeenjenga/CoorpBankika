//
//  AppTab.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Foundation

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
        case .account: "Account"
        }
    }

    func systemImage(isSelected: Bool) -> String {
        switch self {
        case .home: isSelected ? "house.fill" : "house"
        case .budgets: "square.grid.2x2"
        case .add: "plus"
        case .reports: "chart.bar.doc.horizontal"
        case .account: "person"
        }
    }
}
