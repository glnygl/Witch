//
//  GameDetailViewModel.swift
//  Witch
//
//  Created by Glny Gl on 19/10/2024.
//

import SwiftUI

final class GameDetailViewModel {
    
    private let urlOpener: URLOpener
    
    init(urlOpener: URLOpener = UIApplication.shared) {
        self.urlOpener = urlOpener
    }
    
    func openURL(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }                
        if urlOpener.canOpenURL(url) {
            urlOpener.open(url)
        } else {
            return
        }
    }
}
