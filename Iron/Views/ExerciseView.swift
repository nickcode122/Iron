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
    
    @Environment(\.managedObjectContext) var moc
    @State private var showingSheet = false
    @ObservedObject var workout: Workout
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    
    
    
    
    var body: some View {
        VStack {
            Form {
                List {
                    ForEach (workout.exerciseArray, id: \.self) { exercise in
                        NavigationButton(
                            action: {focusedField = nil},
                            destination: {SetView(exercise: exercise)},
                            label: {Text(exercise.wrappedName)}
                        )
                        
                    }
                    .onDelete(perform: removeExercise)
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
            AllExercisesView(exercises: exercises, workout: workout)
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


