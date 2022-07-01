//
//  PersistenceController.swift
//  Iron
//
//  Created by Nick Schwab on 6/6/22.
//
import CoreData
import SwiftUI
import Foundation

struct PersistenceController {
    
    @AppStorage("firstRun") private var firstRun = true
    // A singleton for our entire app to use
    static let shared = PersistenceController()

    // Storage for Core Data
    let container: NSPersistentContainer

    // A test configuration for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)

        return controller
    }()

    // An initializer to load Core Data, optionally able
    // to use an in-memory store.
    init(inMemory: Bool = false) {
        // If you didn't name your model Main you'll need
        // to change this name below.
        container = NSPersistentContainer(name: "Iron")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
                
            }
            
        }
        self.container.viewContext.mergePolicy = NSMergePolicy.overwrite
        
        if firstRun {
            
            let exercises: [ExercisesList] = Bundle.main.decode("ExerciseList.json")
            for exercise in exercises {
                let newExercise = Exercise(context: container.viewContext)
                newExercise.name = exercise.displayName
                save()
            }
            firstRun = false
        }
        
    }
    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Show some error here
            }
        }
    }
}
