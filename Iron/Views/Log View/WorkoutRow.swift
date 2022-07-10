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
            deleteButton
            editButton
        }
        .confirmationDialog("Confirm Delete", isPresented: $showingConfirmation, titleVisibility: .visible) {
            confirmationButtons
        }
        .sheet(isPresented: $showingSheet) {
            EditWorkoutView(workout: workout)
        }
    }
    
    private var editButton: some View {
        Button(action: editWorkout) {
            Label("Edit", systemImage: "pencil")
        }
        .tint(.yellow)
    }
    
    private var deleteButton: some View {
        Button(role: .destructive, action: showConfirmation) {
            Label("Delete", systemImage: "trash.fill")
        }
    }
    private var confirmationButtons: some View {
        Group {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive, action: deleteWorkout)
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
}


