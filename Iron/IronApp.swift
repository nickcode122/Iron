//
//  IronApp.swift
//  Iron
//
//  Created by Nick Schwab on 6/1/22.
//

import SwiftUI

@main
struct IronApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
