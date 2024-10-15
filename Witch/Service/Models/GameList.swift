//
//  GameList.swift
//  Witch
//
//  Created by Glny Gl on 15/10/2024.
//

typealias GameList = [Game]

struct Game: Codable {
    let id: Int?
    let name: String?
    let cover: Cover?
    let url: String?
    let storyline: String?
    let summary: String?
}

struct Cover: Codable {
    let id: Int?
    let url: String?
}
