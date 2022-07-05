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
                deleteButton(workout)
                editButton(workout)
                    .tint(.yellow)
            }
        }
    }
    
    private var sameDay: Bool {
        let sameDay = Calendar.current.isDate(selectedDate, equalTo: workout.wrappedDate, toGranularity: .day)
        return sameDay
    }
    
    private func editButton(_ workout: Workout) -> some View {
        Button {
            editWorkout(workout)
        } label: {
            Label("Edit", systemImage: "pencil")
        }
    }
    
    private func deleteButton(_ workout: Workout) -> some View {
        Button(role: .destructive) {
            deleteWorkout(workout)
        } label: {
            Label("Delete", systemImage: "trash.fill")
        }
    }
    
    private func deleteWorkout(_ workout: Workout) {
        moc.delete(workout)
        PersistenceController.shared.save()
    }
    private func editWorkout(_ workout: Workout) {
        selectedWorkout = workout
    }
}


