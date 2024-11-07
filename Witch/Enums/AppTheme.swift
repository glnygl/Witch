//
//  AppTheme.swift
//  Witch
//
//  Created by Glny Gl on 07/11/2024.
//

import SwiftUI

enum AppTheme: String {
    case light
    case dark
    
    var scheme: ColorScheme {
        switch self {
        case .dark: return .dark
        case .light: return .light
        }
    }
    
    mutating func toggle() {
        self = (self == .light) ? .dark : .light
    }
}
