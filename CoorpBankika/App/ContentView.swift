//
//  ContentView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct ContentView: View {
    let store: BudgetStore

    var body: some View {
        HomeTabView(store: store)
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView(store: BudgetStore(items: BudgetItem.samples))
}
