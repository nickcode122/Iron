//
//  excerciseEntryView.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//

import SwiftUI

struct ExerciseView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var workout: Workout
    
    @State private var showingConfirmation = false
    @State private var showingSheet = false
    var body: some View {
        VStack {
            Form {
                List (workout.exerciseCategories, id: \.self) { category in
                    Section ("\(category.strName)") {
                        ForEach (workout.exerciseArray, id: \.self) { exercise in
                            ExerciseRow(exercise,category, workout)
                                .swipeActions {
                                    deleteButton
                                }
                                .confirmationDialog("Confirm Delete", isPresented: $showingConfirmation, titleVisibility: .visible) {
                                    confirmationDialogButtons(exercise)
                                }
                        }
                    }
                }
                Section {
                    Button("Add Exercise") { showSheet() }
                }
                
                Section("Notes") {
                    TextEditor(text: $workout.strNotes)
                        .frame(height: 150, alignment: .topLeading)
                }
            }
        }
        .navigationTitle("\(workout.wrappedName)")
        
        .sheet(isPresented: $showingSheet) { AllExercisesView(viewState: .add, workout: workout) }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { newWorkoutButton }
            ToolbarItemGroup(placement: .keyboard) { keyboardDoneButton }
        }
    }
    var newWorkoutButton: some View {
        Button (action: showSheet) {
            Label("Edit", systemImage: "plus")
        }
    }
    
    var keyboardDoneButton: some View {
        Group {
            Spacer()
            Button("Done") { UIApplication.shared.endEditing() }
        }
        
    }
    
    func confirmationDialogButtons(_ exercise: ExerciseEntity) -> some View {
        Group {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive, action: {deleteExercise(exercise)})
        }
    }
    private var deleteButton: some View {
        Button(role: .destructive, action: { showingConfirmation = true}) {
            Label("Delete", systemImage: "trash.fill")
        }
    }
    func deleteExercise(_ exercise: ExerciseEntity) {
        moc.delete(exercise)
        PersistenceController.shared.save()
    }
    func showSheet() {
        showingSheet.toggle()
    }
}



