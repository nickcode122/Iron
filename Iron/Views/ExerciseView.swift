//
//  excerciseEntryView.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//

import SwiftUI

struct ExerciseView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var showingSheet = false
    @ObservedObject var workout: Workout
    
    var body: some View {
        VStack {
            Form {
                List {
                    ForEach (workout.exerciseCategories, id: \.self) { category in
                        Section ("\(category.strName)") {
                            ForEach (workout.exerciseArray, id: \.self) { exercise in
                                ExerciseRow(exercise: exercise, category: category, workout: workout)
                            }
                            .onDelete(perform: removeExercise)
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
    
    func removeExercise(at offsets: IndexSet) {
        for index in offsets {
            let set = workout.exerciseArray[index]
            moc.delete(set)
            PersistenceController.shared.save()
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
    func showSheet() {
        showingSheet.toggle()
    }
}



