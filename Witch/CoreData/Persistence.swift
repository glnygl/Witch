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

@Observable
final class PersistenceController: CoreDataPersistenceProtocol {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    var mainContext: NSManagedObjectContext
    var backgroundContext: NSManagedObjectContext
    
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
        
        mainContext = container.viewContext
        backgroundContext = container.newBackgroundContext()
        mainContext.automaticallyMergesChangesFromParent = true
        backgroundContext.automaticallyMergesChangesFromParent = true
    }
    
    private func saveBackgroundContext() {
        do {
            try backgroundContext.save()
            print("Data saved to backgroundContext")
        } catch {
            print("Error saving to backgroundContext \(error.localizedDescription)")
        }
    }
    
    func saveGames(games: GameList?) {
        guard let games = games else { return }
        backgroundContext.performAndWait {
            for game in games {
                let gameData = GameListDataModel(context: backgroundContext)
                gameData.setGame(game: game)
                let coverData = CoverDataModel(context: backgroundContext)
                coverData.setCover(game: game)
                gameData.cover = coverData
                let videoData = VideoDataModel(context: backgroundContext)
                if let videos = game.videos {
                    let videoSet = videoData.setVideos(videos: videos)
                    gameData.videos = videoSet
                }
            }
            saveBackgroundContext()
        }
    }
    
    func fetchGameList() async -> [Game]? {
        let request: NSFetchRequest<GameListDataModel> = GameListDataModel.fetchRequest()
        request.fetchLimit = 20 
        request.fetchBatchSize = 20
        let sortRule = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortRule]
        do {
            let gameList = try mainContext.fetch(request)
            return gameList.map(Game.init)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
