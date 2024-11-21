//
//  GameDetailViewModel.swift
//  Witch
//
//  Created by Glny Gl on 19/10/2024.
//

import SwiftUI
import Network

@Observable
final class GameDetailViewModel {
    
    private let urlOpener: URLOpener
    private let service: GameServiceProtocol
    private let deeplinkManager: DeeplinkManagerProtocol
    
    var gameList: GameList = []
    var game: Game
    
    var name: String { game.name ?? "" }
    var url: String { game.url ?? "" }
    var coverUrl: String? { game.cover?.url }
    var storyline: String? { game.storyline }
    var summary: String { game.summary ?? "" }
    var videoId: String { game.videos?.first?.videoId ?? "" }
    var slug: String { game.slug ?? "" }
    
    var deeplinkUrl: URL {
        deeplinkManager.url(host: .gameDetail, path: slug, queryItems: ["id": "\(game.id)"])
    }

    var error: NetworkError?
    
    var showSummary = false
    var showMore = false
    
    init(service: GameServiceProtocol, game: Game, urlOpener: URLOpener = UIApplication.shared, deeplinkManager: DeeplinkManagerProtocol = DeeplinkManager()) {
        self.service = service
        self.urlOpener = urlOpener
        self.game = game
        self.deeplinkManager = deeplinkManager
    }
    
    @MainActor
    func fetchSimilarGameList(ids: [Int]) async throws {
        do {
            let result = try await service.getSimilarGameList(ids: ids)
            self.gameList = result
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func fetchGameDetail(id: Int) async throws {
        do {
            let result = try await service.getGameDetail(id: id)
            guard let game = result.first else { return }
            self.game = game
        } catch {
            self.error = error
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
    
    func convertStarRating() -> Double {
        guard let rate = game.rating else { return 0.0 }
        return 5 * rate / 100.0
    }
}
