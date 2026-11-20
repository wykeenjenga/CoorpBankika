//
//  BudgetStore.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import Combine
import CoreData
import Foundation
import OSLog

/// Single source of truth for the user's budget.
/// Expenses and the monthly budget live in Core Data; the remaining balance,
/// monthly totals and category split are all worked out from those records.
@MainActor
final class BudgetStore: ObservableObject {
    @Published private(set) var items: [BudgetItem] = []

    let monthlyBudget: Double

    private let persistence: PersistenceController
    private var context: NSManagedObjectContext { persistence.container.viewContext }

    private static let logger = Logger(subsystem: TargetConfiguration.shared.logging.subsystem, category: "BudgetStore")

    init(persistence: PersistenceController = .shared, defaultMonthlyBudget: Double = TargetConfiguration.shared.budget.defaultMonthlyLimit) {
        self.persistence = persistence
        let context = persistence.container.viewContext
        self.monthlyBudget = Self.loadMonthlyBudget(in: context, defaultAmount: defaultMonthlyBudget)
        self.items = Self.loadItems(in: context)
    }

    /// In-memory store filled with `items`. Handy for previews and tests.
    convenience init(items: [BudgetItem], monthlyBudget: Double = 200_000) {
        self.init(persistence: PersistenceController(inMemory: true), defaultMonthlyBudget: monthlyBudget)
        items.forEach { insert($0) }
        save()
        self.items = Self.loadItems(in: context)
    }

    @discardableResult
    func addItem(
        named name: String,
        category: BudgetCategory,
        amount: Double,
        date: Date = .now
    ) -> BudgetItem {
        let item = BudgetItem(name: name, category: category, amount: amount, date: date)
        insert(item)
        save()
        items.insert(item, at: 0)
        return item
    }

    // MARK: - Core Data

    private func insert(_ item: BudgetItem) {
        let entity = ExpenseEntity(context: context)
        entity.id = item.id
        entity.name = item.name
        entity.categoryRawValue = item.category.rawValue
        entity.amount = item.amount
        entity.date = item.date
    }

    private func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            Self.logger.error("Couldn't save the budget database: \(error.localizedDescription)")
        }
    }

    private static func loadItems(in context: NSManagedObjectContext) -> [BudgetItem] {
        let request = ExpenseEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let entities = (try? context.fetch(request)) ?? []
        return entities.map { entity in
            BudgetItem(
                id: entity.id,
                name: entity.name,
                category: BudgetCategory(rawValue: entity.categoryRawValue) ?? .foodAndBeverage,
                amount: entity.amount,
                date: entity.date
            )
        }
    }

    /// Reads the saved budget, or saves `defaultAmount` the first time the app runs.
    private static func loadMonthlyBudget(in context: NSManagedObjectContext, defaultAmount: Double) -> Double {
        if let saved = try? context.fetch(BudgetEntity.fetchRequest()).first {
            return saved.monthlyLimit
        }
        let budget = BudgetEntity(context: context)
        budget.monthlyLimit = defaultAmount
        try? context.save()
        return defaultAmount
    }
}
