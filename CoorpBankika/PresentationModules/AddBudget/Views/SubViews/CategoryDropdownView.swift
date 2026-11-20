//
//  CategoryDropdownView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct CategoryDropdownView: View {
    @Binding var selection: BudgetCategory

    var body: some View {
        Menu {
            Picker("Category", selection: $selection) {
                ForEach(BudgetCategory.allCases) { category in
                    Text(category.title).tag(category)
                }
            }
        } label: {
            HStack {
                Text(selection.title)
                Spacer()
                Image(systemName: "arrowtriangle.down.fill")
                    .font(.system(size: 10))
            }
            .outlinedField(borderColor: .brandSecondary)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Category")
        .accessibilityValue(selection.title)
    }
}

#Preview {
    @Previewable @State var category = BudgetCategory.foodAndBeverage
    CategoryDropdownView(selection: $category)
        .padding()
}
