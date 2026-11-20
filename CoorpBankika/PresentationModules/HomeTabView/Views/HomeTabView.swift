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
    @StateObject private var homeViewModel: HomeViewModel
    @State private var addBudgetPath: [BudgetItem] = []

    init(store: BudgetStore) {
        self.store = store
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(store: store))
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
            NavigationStack(path: $addBudgetPath) {
                AddBudgetView(store: store) { item in
                    addBudgetPath.append(item)
                }
                .navigationDestination(for: BudgetItem.self) { item in
                    BudgetItemAddedView(item: item) {
                        select(.home)
                    }
                }
            }
        case .budgets, .reports, .account:
            ContentUnavailableView {
                Label {
                    Text(selectedTab.title)
                } icon: {
                    Image(selectedTab.icon)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                }
            } description: {
                Text("Coming soon.")
            }
        }
        
    }

    private func select(_ tab: AppTab) {
        addBudgetPath.removeAll()
        selectedTab = tab
    }
}

#Preview {
    HomeTabView(store: BudgetStore(items: BudgetItem.samples))
}
