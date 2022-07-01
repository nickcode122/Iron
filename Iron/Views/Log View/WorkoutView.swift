//
//  WorkoutView.swift
//  Iron
//
//  Created by Nick Schwab on 6/9/22.
//


import CoreData
import SwiftUI

struct WorkoutView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var workouts: FetchedResults<Workout>
    @Environment(\.managedObjectContext) var moc
    
    @State private var showingSheet = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach( workouts, id: \.self) { workout in
                    NavigationLink(destination: ExerciseView(workout: workout)) {
                        Text(workout.wrappedName)
                    }
                    
                }
                .onDelete(perform: removeWorkout)
                
            }
            .navigationBarTitle(Text("All Workouts"), displayMode: .inline)
            .sheet(isPresented: $showingSheet) {
                AddWorkoutView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
    }
   private func removeWorkout(at offsets: IndexSet) {
        for index in offsets {
            let set = workouts[index]
            moc.delete(set)
            PersistenceController.shared.save()
        }
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView()
    }
}
