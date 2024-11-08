//
//  GameListViewModel.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Observation
import Foundation
import Network

protocol GameListViewModelProtocol {
    func fetchGameList() async throws -> [Game]?
    func getGameData() async throws
}

@Observable
final class GameListViewModel: GameListViewModelProtocol {
    
    var gameList: GameList = []
    
    let service: GameServiceProtocol
    private let persistenceController: CoreDataPersistenceProtocol
    
    var isRefreshing: Bool = false
    
    var hasError: Bool = false
    var error: NetworkError?
    
    var showLoading: Bool {
        gameList.isEmpty || isRefreshing
    }
    
    var loadingText: String {
        isRefreshing ? "Refreshing..." : "Loading..."
    }
    
    init(service: GameServiceProtocol, persistenceController: CoreDataPersistenceProtocol) {
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
            self.error = error
            hasError = true
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
