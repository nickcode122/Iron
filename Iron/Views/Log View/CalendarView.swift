//
//  CalendarView.swift
//  Iron
//
//  Created by Nick Schwab on 6/28/22.
//

import SwiftUI

struct CalendarView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var workouts: FetchedResults<Workout>
    
    @State private var selectedDate = Date.now
    @State private var showingSheet = false
    @State var selectedWorkout: Workout?
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    DatePicker("Select a date",selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    
                    Section {
                        List(workouts, id: \.self) { workout in
                            WorkoutRow(workout, $selectedWorkout, $selectedDate)
                        }
                    }
                }
                .fullScreenCover(item: $selectedWorkout,onDismiss: didDismiss) {workout in
                    EditWorkoutView(workout: workout)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addWorkoutButton
                }
            }
            .navigationBarTitle(Text("Workouts"), displayMode: .inline)
            .sheet(isPresented: $showingSheet) { AddWorkoutView() }
        }
    }
    
    private var addWorkoutButton: some View {
        Button(action: addWorkout) {
            Label("Add Workout", systemImage: "plus")
        }
    }
    func addWorkout() {
        showingSheet.toggle()
    }
    private func didDismiss() {
        selectedWorkout = nil
    }
    
}


