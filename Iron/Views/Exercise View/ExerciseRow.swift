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
//    @ObservedObject var category: ExerciseEntityCategory
    @ObservedObject var workout: Workout
    
    @State private var showingConfirmation = false
    
    init(_ exercise: ExerciseEntity, _ workout: Workout) {
        self.exercise = exercise
        self.workout = workout
    }
    
    var body: some View {
//        if categoryMatches {
            NavigationButton( action: { UIApplication.shared.endEditing() }, destination: { SetView(exercise: exercise) }, label: {
                VStack(alignment: .leading) {
                    Text(exercise.wrappedName).font(.headline)
                    Text("Sets: \(exercise.eSet?.count ?? 0)").font(.caption)
                }})
            .foregroundColor(.primary)
//            .contextMenu { categoryButtons }
            .swipeActions {
                deleteButton
            }
            .confirmationDialog("Confirm Delete", isPresented: $showingConfirmation, titleVisibility: .visible) {
                confirmDeleteButton
            }
//        }
    }
    
//    func changeCategory (category: ExerciseEntityCategory) {
//        exercise.category = category
//        PersistenceController.shared.save()
//    }
    
    var navigationButton: some View {
        NavigationButton( action: { UIApplication.shared.endEditing() }, destination: { SetView(exercise: exercise) }, label: {
            VStack(alignment: .leading) {
                Text(exercise.wrappedName).font(.headline)
                Text("Sets: \(exercise.eSet?.count ?? 0)").font(.caption)
            }})
        .foregroundColor(.primary)
    }
    
//    var categoryButtons: some View {
//        ForEach(workout.exerciseCategories) {category in
//            Button (category.strName) {changeCategory(category: category)}
//        }
//    }
    
//    var categoryMatches: Bool {
//        return exercise.category == category
//    }
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
