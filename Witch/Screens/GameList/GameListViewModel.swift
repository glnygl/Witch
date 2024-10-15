//
//  GameListViewModel.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Observation
import Foundation

protocol GameListViewModelProtocol {
    func getGameList() async
}

@Observable
final class GameListViewModel: GameListViewModelProtocol {
    
    var gameList: GameList = []
    
    let service: GameListServiceProtocol
    
    init(service: GameListServiceProtocol) {
        self.service = service
    }
    
    func getGameList() async {
        let result = await service.getGameList()
        
        switch result {
        case .success(let games):
            self.gameList = games
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
