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
    @State private var showingSheet = false

    var body: some View {
        NavigationLink(destination: EditExerciseView(exercise)) {
            Text(exercise.strName)
        }
        .swipeActions {
            DeleteButton(showDeletePrompt)
            PencilEditButton(editExercise)
        }
        .confirmationDialog("Confirm Delete", isPresented: $showingConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive, action: deleteExercise)
        }
        .sheet(isPresented: $showingSheet) {
            EditExerciseView(exercise)
        }
    }
    
    func showDeletePrompt() {
        showingConfirmation.toggle()
    }
    func deleteExercise() {
        moc.delete(exercise)
        PersistenceController.shared.save()
    }
    func editExercise() {
        showingSheet.toggle()
    }

}
