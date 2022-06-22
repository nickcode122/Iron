//
//  AllExercisesView.swift
//  Iron
//
//  Created by Nick Schwab on 6/16/22.
//

import CoreData
import SwiftUI

struct AllExercisesView: View {
    
    let exercises: FetchedResults<Exercise>
    let workout: Workout
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { exercise in
                    Button("\(exercise.wrappedName)") {
                        addExercise(name: exercise.wrappedName)
                    }
                }
                NavigationLink(destination: AddExerciseView(uniqueExercises: uniqueExercises)) {
                    Text("New Exercise")
                }
                
            }
            .searchable(text:$searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("All Exercises")
        }
    }
    
    // Filters exercise array to return only unique elements.
    var uniqueExercises: [Exercise] {
        var uniqueNameArray = [""]
        var uniqueExercisesArray = [Exercise]()
        for exercise in exercises {
            if !uniqueNameArray.contains(exercise.wrappedName) {
                uniqueNameArray.append(exercise.wrappedName)
                uniqueExercisesArray.append(exercise)
            }
        }
        return uniqueExercisesArray
    }
    var searchResults: [Exercise] {
        if searchText.isEmpty {
            return uniqueExercises
        } else {
            return uniqueExercises.filter { $0.wrappedName.contains(searchText)}
        }
    }
    func addExercise (name: String) {
        let newExercise = Exercise(context: moc)
        newExercise.name = name
        newExercise.workout = workout
        newExercise.id = UUID()
        let defaultSet = ESet(context: moc)
        defaultSet.exercise = newExercise
        defaultSet.set = 1
        defaultSet.weight = "45.0"
        defaultSet.reps = "6"
        defaultSet.rpe = "8"
        defaultSet.isComplete = false
        
        PersistenceController.shared.save()
        dismiss()
    }
}
