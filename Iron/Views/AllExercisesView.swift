//
//  AllExercisesView.swift
//  Iron
//
//  Created by Nick Schwab on 6/16/22.
//

import CoreData
import SwiftUI

struct AllExercisesView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    // let exercises: FetchedResults<ExerciseEntity>
    let workout: Workout
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("defaultReps") private var defaultReps = "5"
    @AppStorage("defaultWeight") private var defaultWeight = "45"
    @AppStorage("defaultRPE") private var defaultRPE = "7"
    @AppStorage("defaultRIR") private var defaultRIR = "2"
    
    @State private var searchText = ""
    //    let testData: [ExercisesList] = Bundle.main.decode("ExerciseList.json")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { exercise in
                    Button("\(exercise.strName)") {
                        addExercise(exercise)
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
        newExercise.tag = "main"
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
