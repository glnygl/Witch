//
//  MockPersistenceController.swift
//  WitchTests
//
//  Created by Glny Gl on 20/10/2024.
//

import XCTest
@testable import Witch

final class MockPersistenceController: CoreDataPersistenceProtocol {
    var cachedGames: [Game]?
    var saveCalled = false

    func fetchGameList() async -> [Game]? {
        return cachedGames
    }

    func saveGames(games: [Game]?) {
        saveCalled = true
    }
}
