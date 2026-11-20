//
//  HomeTabView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct HomeTabView: View {
    let store: BudgetStore

    @State private var selectedTab: AppTab = .home
    @State private var homeViewModel: HomeViewModel

    init(store: BudgetStore) {
        self.store = store
        _homeViewModel = State(initialValue: HomeViewModel(store: store))
    }

    var body: some View {
        VStack(spacing: 0) {
            selectedScreen
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            MainTabBarView(selection: selectedTab, onSelect: select)
        }
        .background(Color.surface)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }

    @ViewBuilder
    private var selectedScreen: some View {
        switch selectedTab {
        case .home:
            HomeView(viewModel: homeViewModel)
        case .add:
            NavigationStack {
                AddBudgetView(store: store) { _ in
                    select(.home)
                }
            }
        case .budgets, .reports, .account:
            ContentUnavailableView(
                selectedTab.title,
                systemImage: selectedTab.systemImage(isSelected: false),
                description: Text("Coming soon.")
            )
        }
        
    }

    private func select(_ tab: AppTab) {
        selectedTab = tab
    }
}

#Preview {
    HomeTabView(store: BudgetStore(items: BudgetItem.samples))
}
