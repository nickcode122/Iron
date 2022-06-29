//
//  CalendarView.swift
//  Iron
//
//  Created by Nick Schwab on 6/28/22.
//

import SwiftUI

struct CalendarView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var workouts: FetchedResults<Workout>
    @Environment(\.managedObjectContext) var moc
    
    @State private var selectedDate = Date.now
    @State private var showingSheet = false
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    DatePicker("Select a date",selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.graphical)
                    Section {
                        List {
                            ForEach(workouts, id: \.self) { workout in
                                if sameDay(workoutDate: workout.wrappedDate) {
                                    NavigationLink(destination: ExerciseView(workout: workout)) {
                                        VStack(alignment: .leading) {
                                            Text(workout.wrappedName).font(.headline)
                                            Text("Exercises: \(workout.exercise?.count ?? 0)").font(.caption)
                                        }

                                    }
                                }
                            }
                            .onDelete(perform: removeWorkout)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Label("Add Workout", systemImage: "plus")
                    }
                }
            }
            .navigationBarTitle(Text("Workouts"), displayMode: .inline)
            .sheet(isPresented: $showingSheet) {
                AddWorkoutView()
            }
        }
    }
    
    private func sameDay(workoutDate: Date) -> Bool {
        let sameDay = Calendar.current.isDate(selectedDate, equalTo: workoutDate, toGranularity: .day)
        return sameDay
    }
    
    private func removeWorkout(at offsets: IndexSet) {
         for index in offsets {
             let set = workouts[index]
             moc.delete(set)
             PersistenceController.shared.save()
         }
     }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
