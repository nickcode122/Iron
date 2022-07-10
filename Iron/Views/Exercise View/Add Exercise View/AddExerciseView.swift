//
//  AllExercisesView.swift
//  Iron
//
//  Created by Nick Schwab on 6/16/22.
//

import CoreData
import SwiftUI

struct AddExerciseView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    let workout: Workout
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var searchText = ""
    @Binding public var dismiss: Bool
    
    var body: some View {
        NavigationView {
            List(searchResults, id: \.self) { exercise in
                AddExerciseRow(workout, exercise, $dismiss)
            }
            .searchable(text:$searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Add Exercise")
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
}
