//
//  AppRoutes.swift
//  Witch
//
//  Created by Glny Gl on 21/11/2024.
//

import Coordinator
import SwiftUI
 
enum AppRoutes: Routable, Hashable {
    
    var id: UUID { UUID() }
    case gameList
    case gameDetail(dependencies: GameDetailDependencies)
    
    var body: some View {
        switch self {
        case .gameList:
            GameListCoordinatorView()
        case .gameDetail(let dependencies):
            GameDetailCoordinatorView(dependencies: dependencies)
        }
    }
    
    static func == (lhs: AppRoutes, rhs: AppRoutes) -> Bool {
        lhs.id == rhs.id
    }
}
