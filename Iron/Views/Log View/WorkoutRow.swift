//
//  WorkoutRow.swift
//  Iron
//
//  Created by Nick Schwab on 7/5/22.
//

import SwiftUI

struct WorkoutRow: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var workout: Workout
    
    @State private var showingConfirmation = false
    @State private var showingSheet = false
    
    init(_ workout: Workout) {
        self.workout = workout
    }
    
    var body: some View {
        Group {
            NavigationLink(destination: ExerciseView(workout: workout)) {
                HStack {
                    VStack(alignment: .leading) {
                        Text(workout.wrappedName).font(.headline)
                        Text("Exercises: \(workout.exerciseEntity?.count ?? 0)").font(.caption)
                    }
                    Spacer()
                    Text(workout.wrappedDate.formatted(date: .long, time: .omitted)).font(.caption)
                }
            }
            .swipeActions {
                DeleteButton(showConfirmation)
                PencilEditButton(editWorkout)
            }
            .confirmationDialog("Confirm Delete", isPresented: $showingConfirmation, titleVisibility: .visible) {
                Button("Delete", role: .destructive, action: deleteWorkout)
            }
            .sheet(isPresented: $showingSheet) {
                EditWorkoutView(workout: workout)
            }

        }
    }
    
    private func deleteWorkout() {
        moc.delete(workout)
        PersistenceController.shared.save()
    }
    private func editWorkout() {
        showingSheet.toggle()
    }
    private func showConfirmation() {
        showingConfirmation.toggle()
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Previewing(\.workout) { workout in
                WorkoutRow(workout)
            }
        }
        
    }
}


