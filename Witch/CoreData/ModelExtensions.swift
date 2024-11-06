//
//  ModelExtensions.swift
//  Witch
//
//  Created by Glny Gl on 29/10/2024.
//

import Foundation

extension GameListDataModel {
    func setGame(game: Game) {
        self.id = Int64(game.id)
        self.name = game.name
        self.url = game.url
        self.summary = game.summary
        self.storyline = game.storyline
        self.similarGameIds = game.similarGameIds
        self.rating = game.rating ?? 0.0
        self.slug = game.slug
    }
}

extension CoverDataModel {
    func setCover(game: Game) {
        self.url = game.cover?.url
    }
}

extension VideoDataModel {
    func setVideo(video: Video) {
        self.id = Int64(video.id)
        self.videoId = video.videoId
    }
    
    func setVideos(videos: [Video]) -> NSSet {
        let videoModels = videos.map { videoData -> VideoDataModel in
            self.setVideo(video: videoData)
            return self
        }
        return NSSet(array: videoModels)
    }
}
