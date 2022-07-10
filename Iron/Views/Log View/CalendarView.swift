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
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    DatePicker("Select a date",selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    Section("Workouts from \(sevenDaysAgo.formatted(date: .abbreviated, time: .omitted)) to \(selectedDate.formatted(date: .abbreviated, time: .omitted))") {
                        CalendarFilter(startDate: sevenDaysAgo as NSDate, endDate: selectedDate as NSDate)
                    }
                    Section {
                        addWorkoutButton
                            
                    }
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
        .frame(maxWidth: .infinity, alignment: .center)
    }
    func addWorkout() {
        showingSheet.toggle()
    }
    
    private var sevenDaysAgo: Date {
        Calendar.current.date(byAdding: .weekOfYear, value: -1, to: selectedDate) ?? Date.now
    }
}

