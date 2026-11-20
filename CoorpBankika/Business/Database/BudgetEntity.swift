//
//  BudgetEntity.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import CoreData
import Foundation

/// The monthly budget the remaining balance is worked out from. See CoorpBankika.xcdatamodeld.
@objc(BudgetEntity)
nonisolated final class BudgetEntity: NSManagedObject {
    @NSManaged var monthlyLimit: Double

    @nonobjc class func fetchRequest() -> NSFetchRequest<BudgetEntity> {
        NSFetchRequest<BudgetEntity>(entityName: "BudgetEntity")
    }
}
