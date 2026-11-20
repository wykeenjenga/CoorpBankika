//
//  HomeView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel

    @State private var isShowingAllTransactions = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 14) {
                    BudgetSummaryCardView(remainingBudget: viewModel.remainingBudget)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 16)
                        .background(Color.surface)///this can crash(persay) on dark mode

                    TotalSpendSectionView(
                        totalSpend: viewModel.totalSpend,
                        categorySpends: viewModel.categorySpends,
                        selectedMonth: $viewModel.selectedMonth,
                        monthOptions: viewModel.monthOptions
                    )

                    RecentTransactionsSectionView(items: viewModel.recentItems) {
                        isShowingAllTransactions = true
                    }
                }
            }
            .scrollIndicators(.hidden)
            // Pinned above the scroll view so the greeting stays put while the rest scrolls under it.
            .safeAreaInset(edge: .top, spacing: 0) {
                TopProfileSectionView(userName: viewModel.userName)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 12)
                    .background(Color.surface.ignoresSafeArea(edges: .top))
            }
            .background { background }
            .hidesNavigationBar()
            .navigationDestination(isPresented: $isShowingAllTransactions) {
                AllTransactionsView(items: viewModel.allItems)
            }
        }
    }

    /// White behind the status bar, grey everywhere else so the gaps
    /// between sections read as dividers.
    private var background: some View {
        VStack(spacing: 0) {
            Color.surface.frame(height: 240)
            Color.backgroundLight
        }
        .ignoresSafeArea()
    }
}

#Preview("Empty") {
    HomeView(viewModel: HomeViewModel(store: BudgetStore(items: [])))
}
