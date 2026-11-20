//
//  ExpenseEntity.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import CoreData
import Foundation

/// One expense saved in Core Data. See CoorpBankika.xcdatamodeld.
@objc(ExpenseEntity)
nonisolated final class ExpenseEntity: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String
    @NSManaged var categoryRawValue: String
    @NSManaged var amount: Double
    @NSManaged var date: Date

    @nonobjc class func fetchRequest() -> NSFetchRequest<ExpenseEntity> {
        NSFetchRequest<ExpenseEntity>(entityName: "ExpenseEntity")
    }
}
