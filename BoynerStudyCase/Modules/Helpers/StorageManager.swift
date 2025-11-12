//
//  StorageManager.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 10.11.2025.
//

import CoreData

final class StorageManager {
    /// Shared instance to provide global access
    static let shared = StorageManager()

    /// The persistent container that encapsulates the Core Data stack
    let container: NSPersistentContainer

    var viewContext: NSManagedObjectContext {
        container.viewContext
    }

    private init() {
        // Initialize the persistent container with the data model name
        container = NSPersistentContainer(name: "FavoriteNewSource")
        // Load persistent stores and handle errors
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data store failed: \(error)")
            }
        }

        // Automatically merge changes from background contexts into the main context
        viewContext.automaticallyMergesChangesFromParent = true
    }
}
