//
//  MainTabBarView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct MainTabBarView: View {
    let selection: AppTab
    let onSelect: (AppTab) -> Void

    static let height: CGFloat = 64

    var body: some View {
        HStack(spacing: 0) {
            tabButton(for: .home)
            tabButton(for: .budgets)
            addButton
            tabButton(for: .reports)
            tabButton(for: .account)
        }
        .padding(.horizontal, 6)
        .frame(height: Self.height)
        .background {
            Color.surface
                .shadow(color: .black.opacity(0.06), radius: 8, y: -2)
                .ignoresSafeArea(edges: .bottom)
        }
    }

    private func tabButton(for tab: AppTab) -> some View {
        let isSelected = selection == tab

        return Button {
            onSelect(tab)
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.systemImage(isSelected: isSelected))
                    .font(.system(size: 20))
                    .frame(height: 24)

                Text(tab.title)
                    .font(.system(size: 12, weight: isSelected ? .semibold : .regular))
            }
            .foregroundStyle(isSelected ? Color.brandPrimary : Color.brandSecondary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    private var addButton: some View {
        Button {
            onSelect(.add)
        } label: {
            Image(.addButton)
                .resizable()
                .scaledToFit()
                .frame(width: 58, height: 58)
                .shadow(color: Color.brandGreen.opacity(0.25), radius: 6, y: 3)
        }
        .buttonStyle(.plain)
        .frame(maxWidth: .infinity)
        .offset(y: -12)
        .accessibilityLabel("Add budget item")
    }
}

#Preview {
    VStack {
        Spacer()
        MainTabBarView(selection: .home, onSelect: { _ in })
    }
    .background(Color.backgroundLight)
}
