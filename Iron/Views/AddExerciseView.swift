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
    @State private var selectedCategory = ""
    
    //@FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var allCategories: FetchedResults<ExerciseEntityCategory>
    
    let exercises: [Exercise]
    //let categories: [ExerciseEntityCategory]
    var body: some View {
        
        Form {
            TextField("Exercise Name", text: $exerciseName)
                .multilineTextAlignment(.center)
//            Picker("Choose a category", selection: $selectedCategory) {
//                ForEach(categories, id: \.self) { category in
//                    Text(category.strName)
//                }
//            }
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
//    var categories: [ExerciseEntityCategory] {
//        var categories = [ExerciseEntityCategory]()
//        for category in allCategories {
//            categories.append(category)
//        }
//        return categories
//    }
    func addExercise () {
        let newExercise = Exercise(context: moc)
        newExercise.name = exerciseName
        PersistenceController.shared.save()
        dismiss()
    }
}
