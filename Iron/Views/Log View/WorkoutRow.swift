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
    @Binding var selectedWorkout: Workout?
    @Binding private var selectedDate: Date
    
    @State private var showingConfirmation = false
    
    init(_ workout: Workout, _ selectedWorkout: Binding<Workout?>, _ selectedDate: Binding<Date>) {
        self.workout = workout
        self._selectedWorkout = selectedWorkout
        self._selectedDate = selectedDate
    }
    
    var body: some View {
        if sameDay {
            NavigationLink(destination: ExerciseView(workout: workout)) {
                VStack(alignment: .leading) {
                    Text(workout.wrappedName).font(.headline)
                    Text("Exercises: \(workout.exerciseEntity?.count ?? 0)").font(.caption)
                }
            }
            .swipeActions {
                deleteButton
                editButton
            }
            .confirmationDialog("Confirm Delete", isPresented: $showingConfirmation, titleVisibility: .visible) {
                confirmationButtons
            }
        }
    }
    
    private var sameDay: Bool {
        let sameDay = Calendar.current.isDate(selectedDate, equalTo: workout.wrappedDate, toGranularity: .day)
        return sameDay
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
        selectedWorkout = workout
    }
    private func showConfirmation() {
        showingConfirmation.toggle()
    }
}


