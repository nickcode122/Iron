//
//  ExerciseRow.swift
//  Iron
//
//  Created by Nick Schwab on 7/1/22.
//

import SwiftUI

struct ExerciseRow: View {
    @Environment(\.managedObjectContext) var moc
    
    @ObservedObject var exercise: ExerciseEntity
    
    @State private var showingConfirmation = false
    
    init(_ exercise: ExerciseEntity) {
        self.exercise = exercise
    }
    
    var body: some View {
        NavigationButton( action: { UIApplication.shared.endEditing() }, destination: { SetView(exercise: exercise) }, label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(exercise.wrappedName).font(.headline)
                    Text("Sets: \(exercise.eSet?.count ?? 0)").font(.caption)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .opacity(0.3)
                    .font(.system(size: 14))
            }
        })
        .foregroundColor(.primary)
        
        .swipeActions {
            deleteButton
        }
        .confirmationDialog("Confirm Delete", isPresented: $showingConfirmation, titleVisibility: .visible) {
            confirmDeleteButton
        }
    }
    
    
    var navigationButton: some View {
        NavigationButton( action: { UIApplication.shared.endEditing() }, destination: { SetView(exercise: exercise) }, label: {
            VStack(alignment: .leading) {
                Text(exercise.wrappedName).font(.headline)
                Text("Sets: \(exercise.eSet?.count ?? 0)").font(.caption)
            }})
        .foregroundColor(.primary)
    }
    
    private var deleteButton:  some View {
        Button(role: .destructive, action: showPrompt) {
            Label("Delete", systemImage: "trash.fill")
        }
    }
    var confirmDeleteButton: some View {
        Button("Delete", role: .destructive, action: deleteExercise )
    }
    
    func deleteExercise() {
        moc.delete(exercise)
        PersistenceController.shared.save()
    }
    func showPrompt() {
        showingConfirmation.toggle()
    }
    func editExercise() {
        
    }
}
