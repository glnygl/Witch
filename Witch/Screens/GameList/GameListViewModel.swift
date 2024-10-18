//
//  GameListViewModel.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Observation
import Foundation

protocol GameListViewModelProtocol {
    func fetchGameList() async -> [Game]?
}

@Observable
final class GameListViewModel: GameListViewModelProtocol {
    
    var gameList: GameList = []
    
    let service: GameListServiceProtocol
    let persistenceController: CoreDataPersistenceProtocol
    
    var showLoading: Bool {
        gameList.isEmpty
    }
    
    init(service: GameListServiceProtocol, persistenceController: CoreDataPersistenceProtocol = PersistenceController.shared) {
        self.service = service
        self.persistenceController = PersistenceController.shared
    }
    
    func fetchGameList() async -> [Game]? {
        
        let result = await service.getGameList()
        
        switch result {
        case .success(let games):
            self.gameList = games
            return games
        case .failure(let error):
            print(error.localizedDescription)
            return nil
        }
    }
    
    func getGameData() async {
        if let cachedData = await persistenceController.fetchGameList(), cachedData.count > 0 {
            gameList = cachedData
        } else {
            let data = await fetchGameList()
            persistenceController.saveGames(games: data)
        }
    }
}
