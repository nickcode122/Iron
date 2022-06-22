//
//  excerciseEntryView.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//

import SwiftUI

struct ExerciseView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var showingSheet = false
    @ObservedObject var workout: Workout
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    
    var body: some View {
        VStack {
            List {
                ForEach (workout.exerciseArray, id: \.self) { exercise in
                    NavigationLink (destination:SetView(exercise: exercise )) {
                        Text(exercise.wrappedName)
                    }
                    
                }
                .onDelete(perform: removeExercise)
            }
            
        }
        .navigationTitle("\(workout.wrappedName)")
        .sheet(isPresented: $showingSheet) {
            AllExercisesView(exercises: exercises, workout: workout)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("New Exercise") {
                    showingSheet.toggle()
                }
            }
        }
    }
    func removeExercise(at offsets: IndexSet) {
        for index in offsets {
            let set = workout.exerciseArray[index]
            moc.delete(set)
            PersistenceController.shared.save()
        }
    }
    
}
