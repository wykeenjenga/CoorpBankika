//
//  MyApp.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

@main
struct MyApp: App {
    @State private var budgetStore = BudgetStore()

    var body: some Scene {
        WindowGroup {
            ContentView(store: budgetStore)
        }
    }
}
