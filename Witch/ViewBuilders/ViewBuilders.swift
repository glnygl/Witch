//
//  ViewBuilders.swift
//  Witch
//
//  Created by Glny Gl on 16/10/2024.
//

import SwiftUI

extension View {
    
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
    
    func navigationLink<Destination: View>(_ destination: @escaping () -> Destination) -> some View {
        modifier(NavigationLinkModifier(destination: destination))
    }
    
    func plainList() -> some View {
        self.modifier(PlainListModifier())
    }
    
    func removeNavigationBackButtonTitle() -> some View {
        self.modifier(NavigationBackButtonModifier())
    }
    
    func hide(_ hide: Bool) -> some View {
        ModifiedContent(content: self, modifier: HiddenModifier(hide: hide))
    }
}
