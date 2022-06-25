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
    
    var body: some View {
        VStack {
            Form {
                TextField("Workout Name", text: $workoutName)
                Button("Add") { addWorkout(name: workoutName)}
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .multilineTextAlignment(.center)
            
            
        }
    }
    
    func addWorkout (name: String) {
        let newWorkout = Workout(context: moc)
        newWorkout.id = UUID()
        newWorkout.name = name
        
        PersistenceController.shared.save()
        dismiss()
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
