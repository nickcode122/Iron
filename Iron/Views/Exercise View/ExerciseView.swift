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
                List {
                    ForEach (workout.exerciseArray, id: \.self) { exercise in
                        ExerciseRow(exercise)
                    }
                    .onMove( perform: move)
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
        .navigationBarTitle(Text("\(workout.wrappedName)"), displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { EditButton() }
            ToolbarItemGroup(placement: .keyboard) { keyboardDoneButton }
        }
        .sheet(isPresented: $showingCover) {AddExerciseView(workout, dismiss: $showingCover) }
        
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
    
    private func move(from source: IndexSet, to destination: Int) {
        var revisedItems: [ExerciseEntity] = workout.exerciseArray
        revisedItems.move(fromOffsets: source, toOffset: destination)
        
        for reverseIndex in stride(from: revisedItems.count - 1, through: 0, by: -1) {
            revisedItems[reverseIndex].userOrder = Int16(reverseIndex)
        }
        //forces a change to the observed workout, causing the list to update immediately
        workout.id = UUID()
        PersistenceController.shared.save()
    }
}



