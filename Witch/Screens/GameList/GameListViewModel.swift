//
//  GameListViewModel.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Observation
import Foundation

protocol GameListViewModelProtocol {
    func fetchGameList() async throws -> [Game]?
    func getGameData() async throws
}

@Observable
final class GameListViewModel: GameListViewModelProtocol {
    
    var gameList: GameList = []
    
    let service: GameListServiceProtocol
    private let persistenceController: CoreDataPersistenceProtocol
    
    var showLoading: Bool {
        gameList.isEmpty
    }
    
    init(service: GameListServiceProtocol, persistenceController: CoreDataPersistenceProtocol = PersistenceController.shared) {
        self.service = service
        self.persistenceController = persistenceController
    }
    
    @MainActor
    func fetchGameList() async throws -> [Game]? {
        do {
            let games = try await service.getGameList()
            self.gameList = games
            return games
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    
    @MainActor
    func getGameData() async throws {
        if let cachedData = await persistenceController.fetchGameList(), cachedData.count > 0 {
            gameList = cachedData
        } else {
            let data = try await fetchGameList()
            persistenceController.saveGames(games: data)
        }
    }
}
