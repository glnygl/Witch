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
    
    init(service: GameListServiceProtocol, urlOpener: URLOpener = UIApplication.shared) {
        self.service = service
        self.urlOpener = urlOpener
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
}
