//
//  NavigationButton.swift
//  Iron
//
//  Code from: https://stackoverflow.com/a/58908409
//  License: CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/

import SwiftUI

struct NavigationButton<Destination: View, Label: View>: View {
    var action: () -> Void = { }
    var destination: () -> Destination
    var label: () -> Label

    @State private var isActive: Bool = false

    var body: some View {
        Button(action: {
            self.action()
            self.isActive.toggle()
        }) {
            self.label()
              .background(
                ScrollView { // Fixes a bug where the navigation bar may become hidden on the pushed view
                    NavigationLink(destination: LazyDestination { self.destination() },
                                                 isActive: self.$isActive) { EmptyView() }
                }
              )
        }
    }
}

struct LazyDestination<Destination: View>: View {
    var destination: () -> Destination
    var body: some View {
        self.destination()
    }
}
