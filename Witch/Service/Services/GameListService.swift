//
//  GameListService.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Network

protocol GameListServiceProtocol {
    func getGameList() async throws -> GameList
    func getSimilarGameList(ids: [Int]) async throws -> GameList
}

final class GameListService: GameListServiceProtocol {
    
    private let network: NetworkingProtocol

    init(network: NetworkingProtocol = Networking()) {
        self.network = network
    }
    
    func getGameList() async throws -> GameList {
        var request = GameListRequest()
        let queryBuilder = QueryBuilder()
        let query = queryBuilder
            .addFields([.id, .name, .cover, .url, .summary, .storyline, .rating, .similarGameIds])
            .addCondition(field: .cover, operator: .notEqual, value: "null")
            .addCondition(field: .storyline, operator: .notEqual, value: "null")
            .addCondition(field: .id, operator: .notEqual, value: "null")
            .addLimit(20)
            .build()
        request.parameters = query
        return try await network.request(requestable: request,responseType: GameList.self)
    }
    
    func getSimilarGameList(ids: [Int]) async throws -> GameList {
        var request = SimilarGameListRequest()
        let idQueryString = "(\(ids.compactMap({String($0)}).joined(separator: ",")))"
        let queryBuilder = QueryBuilder()
        let query = queryBuilder
            .addFields([.id, .name, .cover, .url, .summary, .storyline, .rating, .similarGameIds])
            .addCondition(field: .id, operator: .equal, value: idQueryString)
            .addCondition(field: .cover, operator: .notEqual, value: "null")
            .addCondition(field: .storyline, operator: .notEqual, value: "null")
            .addCondition(field: .id, operator: .notEqual, value: "null")
            .build()
        request.parameters = query
        return try await network.request(requestable: request,responseType: GameList.self)
    }

}
