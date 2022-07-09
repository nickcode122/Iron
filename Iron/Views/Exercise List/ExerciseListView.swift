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
            List(searchResults, id: \.self) {exercise in
                ExerciseFilteredListRow(exercise: exercise)
            }
            .searchable(text:$searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("All Exercises")
        }
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


