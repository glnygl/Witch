//
//  GameListService.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Network

protocol GameListServiceProtocol {
    func getGameList() async -> Result<GameList, NetworkError>
}

final class GameListService: GameListServiceProtocol {
    
    private let network: NetworkingProtocol

    init(network: NetworkingProtocol = Networking()) {
        self.network = network
    }
    
    func getGameList() async -> Result<GameList, Network.NetworkError> {
        var request = GameListRequest()
        let queryBuilder = QueryBuilder()
        let query = queryBuilder
            .addFields(["id", "name", "cover", "url", "storyline", "summary"])
                   .build()
        request.parameters = query
        
        return await network.request(requestable: request,responseType: GameList.self)
    }
}
