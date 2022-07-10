//
//  AddWorkoutView.swift
//  Iron
//
//  Created by Nick Schwab on 6/9/22.
//

import SwiftUI

struct AddWorkoutView: View {
    @State private var workoutName = ""
    @State private var exerciseName = ""
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedDate = Date.now
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Workout Name", text: $workoutName)
                    Section("Date") {
                        DatePicker("Date:", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                    Button("Add") { addWorkout(name: workoutName)}
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .multilineTextAlignment(.center)
            }
            .navigationBarTitle(Text("Log Workout"), displayMode: .inline)
        }

    }
    
    func addWorkout (name: String) {
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.name = name
        newWorkout.date = selectedDate
        addDefaultCategories(workout: newWorkout)
        PersistenceController.shared.save()
        dismiss()
    }
    
    func addDefaultCategories(workout: Workout) {
        let newCategory = ExerciseEntityCategory(context: moc)
        newCategory.name = "Warm-up"
        newCategory.workout = workout
        newCategory.id = UUID()
        newCategory.order = 1
        let newCategory2 = ExerciseEntityCategory(context: moc)
        newCategory2.name = "Main"
        newCategory2.workout = workout
        newCategory2.id = UUID()
        newCategory2.order = 2
        let newCategory3 = ExerciseEntityCategory(context: moc)
        newCategory3.name = "Cooldown"
        newCategory3.workout = workout
        newCategory3.id = UUID()
        newCategory3.order = 3
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
