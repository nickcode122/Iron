//
//  AddExerciseView.swift
//  Iron
//
//  Created by Nick Schwab on 6/9/22.
//
import CoreData
import SwiftUI

struct AddExerciseView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var exerciseName = ""
    
    let workout: Workout
    var body: some View {
        Form {
            TextField("Exercise Name", text: $exerciseName)
            Button("Add Exercise") {addExercise(name: exerciseName)}
            
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

//struct AddExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddExerciseView()
//    }
//}
