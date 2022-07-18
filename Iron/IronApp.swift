//
//  IronApp.swift
//  Iron
//
//  Created by Nick Schwab on 6/1/22.
//

import SwiftUI

@main
struct IronApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var viewRouter = ViewRouter()
    
    var body: some Scene {
        let persistenceController = PersistenceController.shared
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewRouter)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
