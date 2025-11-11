//
//  FavoriteNewSourceManager.swift
//  BoynerStudyCase
//
//  Created by Betul Demirci Çelik on 10.11.2025.
//

import CoreData

@MainActor
protocol FavoriteNewSourceManageableProtocol {
    func isFavorite(title: String) async -> Bool
    func addFavorite(id: String, title: String, url: String?) async
    func removeFavorite(title: String) async
    func getFavorites() async -> [FavoriteNewSource]
}

/// Uses Core Data through the shared StorageManager's viewContext
final class FavoriteNewSourceManager: FavoriteNewSourceManageableProtocol {
    private let context = StorageManager.shared.viewContext
}

extension FavoriteNewSourceManager {
    
    /// Checks if a favorite source exists for the given title
    /// - Parameter title: The title of the source to check
    /// - Returns: True if a favorite with the given title exists, false otherwise
    func isFavorite(title: String) async -> Bool {
        await context.perform {
            let request = FavoriteNewSource.fetchRequest()
            request.predicate = NSPredicate(format: "title == %@", title)
            let count = (try? self.context.count(for: request)) ?? 0
            return count > 0
        }
    }
    
    /// Adds a new favorite source to Core Data
    /// - Parameters:
    ///   - id: Unique identifier for the source
    ///   - title: Title of the source
    ///   - url: Optional URL of the source
    func addFavorite(id: String, title: String, url: String?) async {
        await context.perform {
            let item = FavoriteNewSource(context: self.context)
            item.id = id
            item.title = title
            item.url = url
            do {
                try self.context.save()
            } catch {
                print("Core Data save error: \(error)")
            }
        }
    }

    /// Removes a favorite source with the given title
    /// - Parameter title: The title of the source to remove
    func removeFavorite(title: String) async {
        await context.perform {
            let request = FavoriteNewSource.fetchRequest()
            request.predicate = NSPredicate(format: "title == %@", title)
            
            if let list = try? self.context.fetch(request),
               let obj = list.first {
                self.context.delete(obj)
                try? self.context.save()
            }
        }
    }
    
    /// Fetches all favorite sources sorted by title ascending
    /// - Returns: Array of FavoriteNewSource objects
    func getFavorites() async -> [FavoriteNewSource] {
        await context.perform {
            let request: NSFetchRequest<FavoriteNewSource> = FavoriteNewSource.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \FavoriteNewSource.title, ascending: true)]
            return (try? self.context.fetch(request)) ?? []
        }
    }
}
