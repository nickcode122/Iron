//
//  ContentView.swift
//  Iron
//
//  Created by Nick Schwab on 6/1/22.
//
import CoreData
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            WorkoutView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
