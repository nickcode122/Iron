//
//  EditWorkoutView.swift
//  Iron
//
//  Created by Nick Schwab on 7/1/22.
//

import SwiftUI

struct EditWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var workout: Workout
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Workout Name", text: $workout.wrappedName)
                    Section("Date") {
                        DatePicker("Date:", selection: $workout.wrappedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                    }
                    Button("Save") {saveChanges()}
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .multilineTextAlignment(.center)
            }
            .navigationBarTitle(Text("Edit Workout"), displayMode: .inline)
        }
    }
    
    func saveChanges() {
        PersistenceController.shared.save()
        presentationMode.wrappedValue.dismiss()
    }
}
