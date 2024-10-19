//
//  Persistence.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import CoreData
import Foundation

protocol CoreDataPersistenceProtocol {
    func saveGames(games: GameList?)
    func fetchGameList() async -> [Game]?
}

final class PersistenceController: CoreDataPersistenceProtocol {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    var gameList = [GameListDataModel]()
    
    
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
            gameData.id = Int64(game.id)
            gameData.name = game.name
            gameData.url = game.url
            gameData.summary = game.summary
            let coverData = CoverDataModel(context: container.viewContext)
            coverData.url = game.cover?.url
            gameData.cover = coverData
            gameData.storyline = game.storyline
            save()
        }
    }
    
    func fetchGameList() async -> [Game]? {
        let request: NSFetchRequest<GameListDataModel> = GameListDataModel.fetchRequest()
        do {
            gameList = try container.viewContext.fetch(request)
            return gameList.map(Game.init)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
