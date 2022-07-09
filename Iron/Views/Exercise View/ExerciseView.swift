//
//  excerciseEntryView.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//

import SwiftUI

struct ExerciseView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var workout: Workout
    
    @State private var showingConfirmation = false
    @State private var showingCover = false
    
    var body: some View {
        VStack {
            Form {
                List (workout.exerciseArray, id: \.self) { exercise in
                    ExerciseRow(exercise, workout)
                }
                Section {
                    addExerciseButton
                }
                
                Section("Notes") {
                    TextEditor(text: $workout.strNotes)
                        .frame(height: 150, alignment: .topLeading)
                }
            }
        }
        .navigationTitle("\(workout.wrappedName)")
        .sheet(isPresented: $showingCover) {AddExerciseView(workout: workout, dismiss: $showingCover) }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { addExerciseButton }
            ToolbarItemGroup(placement: .keyboard) { keyboardDoneButton }
        }
    }
    var addExerciseButton: some View {
        Button (action: showCover) {
            Label("Add Exercise", systemImage: "plus")
        }
    }
    
    var keyboardDoneButton: some View {
        Group {
            Spacer()
            Button("Done") { UIApplication.shared.endEditing() }
        }
        
    }
    func showCover() {
        withAnimation {
            showingCover.toggle()
        }
    }
}



