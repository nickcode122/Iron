//
//  EditExerciseView.swift
//  Iron
//
//  Created by Nick Schwab on 7/5/22.
//

import SwiftUI

struct EditExerciseView: View {
    @ObservedObject var exercise: Exercise
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    init(_ exercise: Exercise) {
        self.exercise = exercise
    }
    
    var body: some View {
        Form {
            TextField("Exercise Name", text: $exercise.strName)
            Button("Save", action: save)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .multilineTextAlignment(.center)
    }
    private func save() {
        PersistenceController.shared.save()
        presentationMode.wrappedValue.dismiss()
    }
    
}
