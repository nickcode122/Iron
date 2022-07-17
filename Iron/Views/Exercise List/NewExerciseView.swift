//
//  AddExerciseView.swift
//  Iron
//
//  Created by Nick Schwab on 6/9/22.
//
import CoreData
import SwiftUI

struct NewExerciseView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var exerciseName = ""
    @State private var selectedCategory = ""
    
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
        for exercise in exercises {
            names.append(exercise.strName)
        }
        return names
    }
    
    var isUnique: Bool {
        !uniqueExerciseNames.contains(exerciseName)
    }
    func addExercise () {
        let newExercise = Exercise(context: moc)
        newExercise.name = exerciseName
        PersistenceController.shared.save()
        dismiss()
    }
}
