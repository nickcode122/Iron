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
                        DatePicker("Date:", selection: $selectedDate, displayedComponents: .date)
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
        PersistenceController.shared.save()
        dismiss()
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
