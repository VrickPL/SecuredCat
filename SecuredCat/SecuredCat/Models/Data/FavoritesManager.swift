//
//  FavoritesManager.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 30/04/2025.
//

import Foundation
import CoreData

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    
    let persistentContainer: NSPersistentContainer

    @Published var favoriteCatIDs: Set<String> = []
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "FavoriteCats")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.fetchFavorites()
            }
        }
    }
    
    func fetchFavorites() {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<FavoriteCatEntity> = FavoriteCatEntity.fetchRequest()

        do {
            let results = try context.fetch(request)
            self.favoriteCatIDs = Set(results.compactMap { $0.id })
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func isFavorite(catID: String) -> Bool {
        favoriteCatIDs.contains(catID)
    }
    
    func toggleFavorite(cat: Cat) {
        let context = persistentContainer.viewContext

        if isFavorite(catID: cat.id) {
            let fetchRequest: NSFetchRequest<FavoriteCatEntity> = FavoriteCatEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", cat.id)

            if let results = try? context.fetch(fetchRequest),
               let favorite = results.first {
                context.delete(favorite)
            }
            favoriteCatIDs.remove(cat.id)
        } else {
            let favorite = FavoriteCatEntity(context: context)
            favorite.id = cat.id
            favorite.url = cat.url

            do {
                try context.save()
                favoriteCatIDs.insert(cat.id)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getFavoriteCats() -> [Cat] {
            let context = persistentContainer.viewContext
            let request: NSFetchRequest<FavoriteCatEntity> = FavoriteCatEntity.fetchRequest()

            do {
                let results = try context.fetch(request)
                return results.compactMap { entity in
                    if let id = entity.id, let url = entity.url {
                        return Cat(id: id, url: url, breeds: nil)
                    }
                    return nil
                }
            } catch {
                print(error.localizedDescription)
                return []
            }
        }
}
