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
        TabView {
            CalendarView()
                .tabItem {
                    Label("Log", systemImage:"calendar")
                }
            ExerciseListView()
                .tabItem {
                    Label("Exercise List", systemImage: "list.dash")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
