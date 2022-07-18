//
//  ContentView.swift
//  Iron
//
//  Created by Nick Schwab on 6/1/22.
//
import CoreData
import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewRouter: ViewRouter
    var body: some View {
        TabView(selection: $viewRouter.currentView) {
            TemplateView()
                .tabItem {
                    Label("Templates", systemImage: "list.bullet.rectangle.portrait.fill")
                }
                .tag(AppView.templates)
            CalendarView()
                .tabItem {
                    Label("Log", systemImage:"calendar")
                }
                .tag(AppView.logs)
            ExerciseListView()
                .tabItem {
                    Label("Exercise List", systemImage: "list.dash")
                }
                .tag(AppView.list)
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(AppView.settings)

        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
