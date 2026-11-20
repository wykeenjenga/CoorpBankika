//
//  AllocationFieldView.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import SwiftUI

struct AllocationFieldView: View {
    let currencyCode: String
    @Binding var amountText: String
    var focus: FocusState<AddBudgetField?>.Binding

    var body: some View {
        HStack(spacing: 12) {
            // Only Kenyan Shillings for now; the menu shows what's in use.
            Menu {
                Label("Kenyan Shilling (\(currencyCode))", systemImage: "checkmark")
            } label: {
                HStack(spacing: 6) {
                    Text(currencyCode)
                        .font(.system(size: 13))
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.system(size: 8))
                }
                .foregroundStyle(Color.brandSecondary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Currency")
            .accessibilityValue(currencyCode)

            TextField("0", text: $amountText)
                .decimalKeyboard()
                .focused(focus, equals: .allocation)
                .accessibilityLabel("Allocation")
        }
        .outlinedField(isFocused: focus.wrappedValue == .allocation)
    }
}

#Preview {
    @Previewable @State var amount = "5000"
    @Previewable @FocusState var focus: AddBudgetField?
    AllocationFieldView(currencyCode: "KSh", amountText: $amount, focus: $focus)
        .padding()
}
