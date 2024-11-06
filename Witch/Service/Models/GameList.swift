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
    let rating: Double?
    let similarGameIds: [Int]?
    let videos: [Video]?
    
    enum CodingKeys: String, CodingKey {
        case id, name, cover, url, storyline, summary, rating, videos
        case similarGameIds = "similar_games"
    }
    
    init(id: Int, name: String?, cover: Cover?, url: String?, storyline: String?, summary: String?, rating: Double?, similarGameIds: [Int]?, videos: [Video]?) {
        self.id = id
        self.name = name
        self.cover = cover
        self.url = url
        self.storyline = storyline
        self.summary = summary
        self.rating = rating
        self.similarGameIds = similarGameIds
        self.videos = videos
    }
    
    init(entity: GameListDataModel) {
        self.id = Int(entity.id)
        self.name = entity.name
        self.cover = Cover.init(entity: entity.cover)
        self.url = entity.url
        self.storyline = entity.storyline
        self.summary = entity.summary
        self.rating = entity.rating
        self.similarGameIds = entity.similarGameIds
        
        if let videoSet = entity.videos as? Set<VideoDataModel> {
            self.videos = videoSet.map { Video(entity: $0) }
        } else {
            self.videos = nil
        }
    }
}

struct Cover: Codable {
    let url: String?
    
    init(entity: CoverDataModel?) {
        self.url = entity?.url
    }
}

struct Video: Codable {
    let id: Int
    let videoId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case videoId = "video_id"
    }
    
    init(entity: VideoDataModel?) {
        self.id = Int(entity?.id ?? 0)
        self.videoId = entity?.videoId
    }
}


