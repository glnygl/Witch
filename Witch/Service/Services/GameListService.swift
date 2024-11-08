//
//  GameListService.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

import Network
import SwiftUI

protocol GameServiceProtocol {
    func getGameList() async throws (NetworkError) -> GameList
    func getSimilarGameList(ids: [Int]) async throws (NetworkError) -> GameList
    func getGameDetail(id: Int) async throws (NetworkError) -> GameList
}

@Observable
final class GameService: GameServiceProtocol {
    
    private let network: NetworkingProtocol

    init(network: NetworkingProtocol = Networking()) {
        self.network = network
    }
    
    func getGameList() async throws (NetworkError) -> GameList {
        var request = GameListRequest()
        let queryBuilder = QueryBuilder()
        let query = queryBuilder
            .addFields([.id, .name, .cover, .url, .summary, .storyline, .rating, .similarGameIds, .videoIds, .slug])
            .addConditions(fields: [.cover, .storyline, .id, .videoIds, .slug], operator: .notEqual, value: "null")
            .addLimit(20)
            .build()
        request.parameters = query
        return try await network.request(requestable: request,responseType: GameList.self)
    }
    
    func getSimilarGameList(ids: [Int]) async throws (NetworkError) -> GameList {
        var request = SimilarGameListRequest()
        let idQueryString = "(\(ids.compactMap({String($0)}).joined(separator: ",")))"
        let queryBuilder = QueryBuilder()
        let query = queryBuilder
            .addFields([.id, .name, .cover, .url, .summary, .storyline, .rating, .similarGameIds])
            .addCondition(field: .id, operator: .equal, value: idQueryString)
            .addConditions(fields: [.cover, .storyline, .id], operator: .notEqual, value: "null")
            .build()
        request.parameters = query
        return try await network.request(requestable: request,responseType: GameList.self)
    }
    
    func getGameDetail(id: Int) async throws (NetworkError) -> GameList {
        var request = GameDetailRequest()
        let queryBuilder = QueryBuilder()
        let query = queryBuilder
            .addFields([.id, .name, .cover, .url, .summary, .storyline, .rating, .similarGameIds])
            .addConditions(fields: [.cover, .storyline], operator: .notEqual, value: "null")
            .addCondition(field: .id, operator: .equal, value: "\(id)")
            .build()
        request.parameters = query
        return try await network.request(requestable: request,responseType: GameList.self)
    }

}
