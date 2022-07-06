//
//  ExerciseListView.swift
//  Iron
//
//  Created by Nick Schwab on 7/6/22.
//

import SwiftUI

/// View with a list of all Exercises
struct ExerciseListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    
    @State private var searchText = ""
    
    @State private var showingConfirmation = false
    var body: some View {
        NavigationView {
            ExerciseFilteredList(filter: searchText)
            .searchable(text:$searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("All Exercises")
        }
    }
    
    private var deleteButton: some View {
        Button(role: .destructive, action: { showingConfirmation = true}) {
            Label("Delete", systemImage: "trash.fill")
        }
        
    }

    private var editButton: some View {
        Button(action: editExercise) {
            Label("Edit", systemImage: "pencil")
        }
        .tint(.yellow)
    }
    
    func confirmationButtons(_ exercise: Exercise) -> some View {
        Group {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive, action: { deleteExercise(exercise)} )
        }
    }
    
    func deleteExercise(_ exercise: Exercise) {
        moc.delete(exercise)
        PersistenceController.shared.save()
    }
    
    func editExercise() {
        
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
}


