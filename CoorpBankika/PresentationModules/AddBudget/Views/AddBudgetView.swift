//
//  AddBudgetView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct AddBudgetView: View {
    @State private var viewModel: AddBudgetViewModel
    @FocusState private var focusedField: AddBudgetField?

    private let onItemCreated: (BudgetItem) -> Void

    init(store: BudgetStore, onItemCreated: @escaping (BudgetItem) -> Void) {
        _viewModel = State(initialValue: AddBudgetViewModel(store: store))
        self.onItemCreated = onItemCreated
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                Text("Add New Budget Item")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(Color.brandSecondary)
                    .padding(.bottom, 2)

                FormFieldView(title: "Category") {
                    CategoryDropdownView(selection: $viewModel.category)
                }

                FormFieldView(title: "Item Name") {
                    TextField("e.g. KFC Chicken", text: $viewModel.itemName)
                        .focused($focusedField, equals: .itemName)
                        .submitLabel(.next)
                        .onSubmit { focusedField = .allocation }
                        .outlinedField(isFocused: focusedField == .itemName)
                }

                FormFieldView(title: "Allocation") {
                    AllocationFieldView(
                        currencyCode: viewModel.currencyCode,
                        amountText: $viewModel.allocationText,
                        focus: $focusedField
                    )
                    .onChange(of: viewModel.allocationText) {
                        Task { viewModel.sanitizeAllocationText() }
                    }
                }

                Button("Create New Budget Item", action: submit)
                    .buttonStyle(.filled(.brandPrimary, foreground: .brandGreen))
                    .disabled(!viewModel.canSubmit)
                    .padding(.top, 24)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(Color.surface)
        .hidesNavigationBar()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") { focusedField = nil }
            }
        }
    }

    private func submit() {
        guard let item = viewModel.createItem() else { return }
        focusedField = nil
        onItemCreated(item)
    }
}

#Preview {
    NavigationStack {
        AddBudgetView(store: BudgetStore(items: [])) { _ in }
    }
}
