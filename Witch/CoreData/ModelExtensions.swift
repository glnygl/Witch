//
//  ModelExtensions.swift
//  Witch
//
//  Created by Glny Gl on 29/10/2024.
//

extension GameListDataModel {
    func setGame(game: Game) {
        self.id = Int64(game.id)
        self.name = game.name
        self.url = game.url
        self.summary = game.summary
        self.storyline = game.storyline
        self.similarGameIds = game.similarGameIds
        self.rating = game.rating ?? 0.0
    }
}

extension CoverDataModel {
    func setCover(game: Game) {
        self.url = game.cover?.url
    }
}
