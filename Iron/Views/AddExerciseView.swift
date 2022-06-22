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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    
    let uniqueExercises: [Exercise]
    
    var body: some View {
        
        Form {
            TextField("Exercise Name", text: $exerciseName)
                .multilineTextAlignment(.center)
            Button("Add Exercise") {addExercise()}
                .frame(maxWidth: .infinity, alignment: .center)
                .disabled(!isUnique)
        }
        
    }
    
    var uniqueExerciseNames: [String] {
        var names = [String]()
        for exercise in uniqueExercises {
            names.append(exercise.wrappedName)
        }
        return names
    }
    
    var isUnique: Bool {
        !uniqueExerciseNames.contains(exerciseName)
    }
    func addExercise () {
        
        let newExercise = Exercise(context: moc)
        newExercise.name = exerciseName
        newExercise.id = UUID()
        
        PersistenceController.shared.save()
        dismiss()
    }
}
