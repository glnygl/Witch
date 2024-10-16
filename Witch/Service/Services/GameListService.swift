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
        queryBuilder.limit = 20
        let query = queryBuilder
            .addFields([.id, .name, .cover, .url, .summary, .storyline])
            .addCondition(field: .cover, operator: .notEqual, value: "null")
            .addCondition(field: .storyline, operator: .notEqual, value: "null")
                   .build()
        request.parameters = query
        
        return await network.request(requestable: request,responseType: GameList.self)
    }
}
