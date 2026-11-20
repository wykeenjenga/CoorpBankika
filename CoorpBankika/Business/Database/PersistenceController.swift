//
//  PersistenceController.swift
//  CoorpBankika
//
//  Created by Wycliff Njenga on 20/11/2026.
//

import CoreData
import Foundation

/// Sets up the Core Data stack the budget is stored in.
nonisolated final class PersistenceController: @unchecked Sendable {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    /// Loaded once so previews and tests that make extra in-memory stores share the same model.
    private static let model: NSManagedObjectModel = {
        guard
            let url = Bundle.main.url(forResource: "CoorpBankika", withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: url)
        else {
            fatalError("Couldn't find the CoorpBankika Core Data model")
        }
        return model
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoorpBankika", managedObjectModel: Self.model)

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Couldn't open the budget database: \(error)")
            }
        }

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
