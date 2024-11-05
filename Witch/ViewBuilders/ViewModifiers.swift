//
//  ViewModifiers.swift
//  Witch
//
//  Created by Glny Gl on 16/10/2024.
//

import SwiftUI

struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

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

struct EmbedInSection: ViewModifier {
    func body(content: Content) -> some View {
        Section {
            content
        }
    }
}

struct HiddenModifier: ViewModifier {
    let hide: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if hide {
            content.hidden()
        } else {
            content
        }
    }
}

