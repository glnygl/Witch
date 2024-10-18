//
//  GameList.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

typealias GameList = [Game]

struct Game: Codable {
    
    let id: Int
    let name: String?
    let cover: Cover?
    let url: String?
    let storyline: String?
    let summary: String?
    
    init(entity: GameListDataModel) {
        self.id = Int(entity.id)
        self.name = entity.name
        self.cover = Cover.init(entity: entity.cover)
        self.url = entity.url
        self.storyline = entity.storyline
        self.summary = entity.summary
    }
}

struct Cover: Codable {
    let url: String?
    
    init(entity: CoverDataModel?) {
        self.url = entity?.url
    }
}


