//
//  EnvironmentValues.swift
//  Witch
//
//  Created by Glny Gl on 07/11/2024.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var appTheme: AppTheme = .light
    @Entry var gameService: GameServiceProtocol = GameService()
}
