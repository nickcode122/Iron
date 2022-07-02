//
//  ExerciseRow.swift
//  Iron
//
//  Created by Nick Schwab on 7/1/22.
//

import SwiftUI

struct ExerciseRow: View {
    @ObservedObject var exercise: ExerciseEntity
    @ObservedObject var category: ExerciseEntityCategory
    @ObservedObject var workout: Workout
    
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        if categoryMatches {
            exerciseNavigationRow
            .contextMenu { categoryButtons }
        }
    }
    
    func changeCategory (category: ExerciseEntityCategory) {
        exercise.category = category
        PersistenceController.shared.save()
    }
    
    var exerciseNavigationRow: some View {
        NavigationButton(
            action: { UIApplication.shared.endEditing() },
            destination: { SetView(exercise: exercise) },
            label: {
                VStack(alignment: .leading) {
                    Text(exercise.wrappedName).font(.headline)
                    Text("Sets: \(exercise.eSet?.count ?? 0)").font(.caption)
                }
            }
        )
        .foregroundColor(.primary)
    }
    
    var categoryButtons: some View {
        ForEach(workout.exerciseCategories) {category in
            Button (category.strName) {changeCategory(category: category)}
        }
    }
    
    var categoryMatches: Bool {
        return exercise.category == category
    }
}
