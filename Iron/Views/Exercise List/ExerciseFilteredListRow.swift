//
//  ExerciseFilteredListRow.swift
//  Iron
//
//  Created by Nick Schwab on 7/6/22.
//

import SwiftUI

struct ExerciseFilteredListRow: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var exercise: Exercise
    @State private var showingConfirmation = false
    
    init(_ exercise: Exercise) {
        self.exercise = exercise
    }
    var body: some View {
        NavigationLink(destination: EditExerciseView(exercise)) {
            Text(exercise.strName)
        }
        .swipeActions {
            deleteButton
            editButton
        }
        .confirmationDialog("Confirm Delete", isPresented: $showingConfirmation, titleVisibility: .visible) {
            confirmDeleteButton
        }
    }
    private var deleteButton:  some View {
        Button(role: .destructive, action: { showingConfirmation.toggle()}) {
            Label("Delete", systemImage: "trash.fill")
        }
    }
    private var editButton: some View {
        Button(action: editExercise) {
            Label("Edit", systemImage: "pencil")
        }
        .tint(.yellow)
    }
    
    var confirmDeleteButton: some View {
        Button("Delete", role: .destructive, action: { deleteExercise(exercise)} )
    }
    
    func deleteExercise(_ exercise: Exercise) {
        moc.delete(exercise)
        PersistenceController.shared.save()
    }
    
    func editExercise() {
        
    }

}
