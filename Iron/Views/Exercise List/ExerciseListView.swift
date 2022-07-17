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
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            List(searchResults, id: \.self) {exercise in
                ExerciseFilteredListRow(exercise: exercise)
            }
            .searchable(text:$searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("All Exercises")
            .toolbar { newExerciseToolbarItem }
            .sheet(isPresented: $showSheet) { NewExerciseView() }
        }
    }
    
    var searchResults: [Exercise] {
        let exerciseArray: [Exercise] = exercises.map { $0 }
        if searchText.isEmpty {
            return exerciseArray
        } else {
            return exerciseArray.filter { $0.strName.contains(searchText)}
        }
    }
    var newExerciseToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: showNewExerciseView) {
                Label("Add Exercise", systemImage: "plus")
            }
        }
    }
    func showNewExerciseView() {
        showSheet.toggle()
    }
}


