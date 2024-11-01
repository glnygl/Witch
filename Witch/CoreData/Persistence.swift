//
//  Persistence.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import CoreData

protocol CoreDataPersistenceProtocol {
    func saveGames(games: GameList?)
    func fetchGameList() async -> [Game]?
}

final class PersistenceController: CoreDataPersistenceProtocol {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "WitchDataModel")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to Core Data \(error.localizedDescription)")
        }
    }
    
    
    func saveGames(games: GameList?) {
        guard let games = games else { return }
        for game in games {
            let gameData = GameListDataModel(context: container.viewContext)
            gameData.setGame(game: game)
            let coverData = CoverDataModel(context: container.viewContext)
            coverData.setCover(game: game)
            gameData.cover = coverData
        }
        save()
    }
    
    func fetchGameList() async -> [Game]? {
        let request: NSFetchRequest<GameListDataModel> = GameListDataModel.fetchRequest()
        do {
            let gameList = try container.viewContext.fetch(request)
            return gameList.map(Game.init)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
