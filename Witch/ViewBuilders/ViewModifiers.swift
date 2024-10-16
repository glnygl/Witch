//
//  ViewModifiers.swift
//  Witch
//
//  Created by Glny Gl on 16/10/2024.
//

import SwiftUI

struct NavigationLinkModifier<Destination: View>: ViewModifier {
    
    @ViewBuilder var destination: () -> Destination
    
    func body(content: Content) -> some View {
        content
            .background(
                NavigationLink(destination: self.destination) {
                    EmptyView()
                }.opacity(0)
            )
    }
}

struct PlainListModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
    }
}


struct NavigationBackButtonModifier: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                        }
                    }
                }
            }
    }
}

