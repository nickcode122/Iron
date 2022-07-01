//
//  excerciseEntryView.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//

import SwiftUI

struct ExerciseView: View {
    
    private enum Field: Int, CaseIterable {
        case notes
    }
    
    @FocusState private var focusedField: Field?
    @State var updater: Bool = false
    @Environment(\.managedObjectContext) var moc
    @State private var showingSheet = false
    
    @ObservedObject var workout: Workout
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<ExerciseEntity>
    
    var body: some View {
        VStack {
            if updater {} //hacked solution - refactor at a later date
            Form {
                List {
                    Section("Warmup") {
                        ForEach (workout.exerciseArray, id: \.self) { exercise in
                            if exercise.strTag == "warmup" { ExerciseRow(exercise,  $updater) }
                        }
                        .onDelete(perform: removeExercise)
                    }
                    Section("Main") {
                        ForEach (workout.exerciseArray, id: \.self) { exercise in
                            if exercise.strTag == "main" { ExerciseRow(exercise, $updater) }
                        }
                        .onDelete(perform: removeExercise)
                    }
                    Section("Cooldown") {
                        ForEach (workout.exerciseArray, id: \.self) { exercise in
                            if exercise.strTag == "cooldown" { ExerciseRow( exercise, $updater) }
                        }
                        .onDelete(perform: removeExercise)
                    }
                }
                Section {
                    Button("Add Exercise") { showingSheet.toggle() }
                }
                
                Section("Notes") {
                    TextEditor(text: $workout.strNotes)
                        .focused($focusedField, equals: .notes)
                        .frame(height: 150, alignment: .topLeading)
                }
            }     
        }
        .navigationTitle("\(workout.wrappedName)")
        
        .sheet(isPresented: $showingSheet) {
            AllExercisesView(viewState: .add, workout: workout)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingSheet.toggle()
                } label: {
                    Label("New Workout", systemImage: "plus")
                }
            }
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {focusedField = nil}
            }
        }
    }
    func removeExercise(at offsets: IndexSet) {
        for index in offsets {
            let set = workout.exerciseArray[index]
            moc.delete(set)
            PersistenceController.shared.save()
        }
    }
}


