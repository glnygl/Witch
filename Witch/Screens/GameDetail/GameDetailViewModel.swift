//
//  GameDetailViewModel.swift
//  Witch
//
//  Created by Glny Gl on 19/10/2024.
//

import SwiftUI

@Observable
final class GameDetailViewModel {
    
    private let urlOpener: URLOpener
    private let service: GameListServiceProtocol
    
    var gameList: GameList = []
    var game: Game
    
    var name: String {
        game.name ?? ""
    }
    
    var url: String {
        game.url ?? ""
    }
    
    var coverUrl: String? {
        game.cover?.url
    }
    
    var storyline: String {
        game.storyline ?? ""
    }
    
    var summary: String {
        game.summary ?? ""
    }
    
    init(service: GameListServiceProtocol, game: Game, urlOpener: URLOpener = UIApplication.shared) {
        self.service = service
        self.urlOpener = urlOpener
        self.game = game
    }
    
    func fetchSimilarGameList(ids: [Int]) async {
        
        let result = await service.getSimilarGameList(ids: ids)
        
        switch result {
        case .success(let games):
            self.gameList = games
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func openURL(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }                
        if urlOpener.canOpenURL(url) {
            urlOpener.open(url)
        } else {
            return
        }
    }
    
    
    func convertRating() -> Double {
        guard let rate = game.rating else { return 0.0 }
        return 5 * rate / 100.0
    }
}
