//
//  AddBudgetViewModel.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Combine
import Foundation

@MainActor
final class AddBudgetViewModel: ObservableObject {
    @Published var category: BudgetCategory = .foodAndBeverage
    @Published var itemName = ""
    @Published var allocationText = ""

    let currencyCode = "KSh"

    private let store: BudgetStore
    private let decimalSeparator: Character

    init(store: BudgetStore, locale: Locale = .current) {
        self.store = store
        self.decimalSeparator = locale.decimalSeparator?.first ?? "."
    }

    var allocation: Double? {
        Double(allocationText.replacingOccurrences(of: String(decimalSeparator), with: "."))
    }

    var canSubmit: Bool {
        !trimmedName.isEmpty && (allocation ?? 0) > 0
    }

    /// Call whenever `allocationText` changes so pasted or typed junk is cleaned up.
    func allocationChanged() {
        let sanitized = Self.sanitizedAmount(allocationText, decimalSeparator: decimalSeparator)
        if sanitized != allocationText {
            allocationText = sanitized
        }
    }

    /// Keeps digits and the first locale decimal separator, with at most two decimals.
    /// Anything else, including grouping separators like the comma in `1,500`, is dropped.
    static func sanitizedAmount(_ text: String, decimalSeparator: Character) -> String {
        var sanitized = ""
        var hasDecimalSeparator = false
        var decimals = 0

        for character in text {
            if character.isASCII, character.isNumber {
                if hasDecimalSeparator {
                    guard decimals < 2 else { continue }
                    decimals += 1
                }
                sanitized.append(character)
            } else if character == decimalSeparator, !hasDecimalSeparator {
                hasDecimalSeparator = true
                sanitized.append(character)
            }
        }

        return sanitized
    }

    /// Saves the item and clears the form. Returns `nil` when the form isn't valid.
    func createItem() -> BudgetItem? {
        guard canSubmit, let allocation else { return nil }

        let item = store.addItem(named: trimmedName, category: category, amount: allocation)
        reset()
        return item
    }

    private var trimmedName: String {
        itemName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func reset() {
        category = .foodAndBeverage
        itemName = ""
        allocationText = ""
    }
}
