//
//  AllExercisesView.swift
//  Iron
//
//  Created by Nick Schwab on 6/16/22.
//

import CoreData
import SwiftUI

public enum AllExercisesState {
    case add, view
}
struct AllExercisesView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    let workout: Workout?
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("defaultReps") private var defaultReps = "5"
    @AppStorage("defaultWeight") private var defaultWeight = "45"
    @AppStorage("defaultRPE") private var defaultRPE = "7"
    @AppStorage("defaultRIR") private var defaultRIR = "2"
    let viewState: AllExercisesState
    @State private var searchText = ""
    
    init(viewState: AllExercisesState) {
        self.viewState = viewState
        self.workout = nil
    }
    init(viewState: AllExercisesState, workout: Workout) {
        self.viewState = viewState
        self.workout = workout
    }
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { exercise in
                    
                    switch viewState {
                    case .add:
                        Button("\(exercise.strName)") {addExercise(exercise)}
                    case .view:
                        NavigationLink(destination: Text(exercise.strName)) {
                            Text(exercise.strName)
                        }
                    }
                }
                NavigationLink(destination: AddExerciseView(exercises: exerciseArray)) {
                    Text("New Exercise")
                }
                
            }
            .searchable(text:$searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("All Exercises")
        }
    }
    
    func removeExercise() {
        // remove exercise logic ...
        // will need to remove all exercises with the same name
    }
    
    var exerciseArray: [Exercise] {
        var exerciseArray = [Exercise]()
        for exercise in exercises {
            exerciseArray.append(exercise)
        }
        return exerciseArray
    }
    var searchResults: [Exercise] {
        if searchText.isEmpty {
            return exerciseArray
        } else {
            return exerciseArray.filter { $0.strName.contains(searchText)}
        }
    }
    func addExercise (_ exercise: Exercise) {
        let newExercise = ExerciseEntity(context: moc)
        newExercise.exercise = exercise
        newExercise.name = exercise.strName
        newExercise.workout = workout
        newExercise.id = UUID()
        newExercise.category = workout?.exerciseCategories[1]
        let defaultSet = ESet(context: moc)
        defaultSet.exerciseEntity = newExercise
        defaultSet.set = 1
        defaultSet.weight = defaultWeight
        defaultSet.reps = defaultReps
        defaultSet.rpe = defaultRPE
        defaultSet.rir = defaultRIR
        defaultSet.isComplete = false
        
        PersistenceController.shared.save()
        dismiss()
    }
}
