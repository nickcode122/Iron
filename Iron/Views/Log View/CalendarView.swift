//
//  CalendarView.swift
//  Iron
//
//  Created by Nick Schwab on 6/28/22.
//

import SwiftUI

struct CalendarView: View {
    
    @State private var selectedDate = Date.now
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    DatePicker("Select a date",selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    Section("Workouts from \(sevenDaysAgo.formatted(date: .abbreviated, time: .omitted)) to \(selectedDate.formatted(date: .abbreviated, time: .omitted))") {
                        CalendarFilter(startDate: sevenDaysAgo as NSDate, endDate: adjustedDate as NSDate)
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
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Previewing(contextWith: \.workouts) {
                CalendarView()
            }
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
        Calendar.current.date(byAdding: .weekOfYear, value: -1, to: removeTime(selectedDate)) ?? Date.now
    }

    private var adjustedDate: Date {
        var adjustedDate = Calendar.current.date(byAdding: .day, value: 1, to: removeTime(selectedDate)) ?? Date.now
        adjustedDate = Calendar.current.date(byAdding: .second, value: -1, to: adjustedDate) ?? Date.now
        return adjustedDate
    }
    private func removeTime(_ date: Date) -> Date {
        let components = Calendar.current.dateComponents([.day,.month,.year], from: date)
        let newDate = Calendar.current.date(from: components) ?? Date.now
        return newDate
    }
}

