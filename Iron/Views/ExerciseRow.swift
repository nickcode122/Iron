//
//  ExerciseRow.swift
//  Iron
//
//  Created by Nick Schwab on 6/30/22.
//

import SwiftUI

struct ExerciseRow: View {
    @ObservedObject var exercise: ExerciseEntity
    @Binding var updater: Bool
    
    init(_ exercise: ExerciseEntity, _ updater: Binding<Bool>) {
        self.exercise = exercise
        self._updater = updater
    }
    var body: some View {
        NavigationButton(
            action: {UIApplication.shared.endEditing()},
            destination: {SetView(exercise: exercise)},
            label: {
                VStack(alignment: .leading) {
                    Text(exercise.wrappedName).font(.headline)
                    Text("Sets: \(exercise.eSet?.count ?? 0)").font(.caption)
                }
            }
        )
        .foregroundColor(.primary)
        .contextMenu {
            Button ("Warmup") {exercise.tag = "warmup"
                updater.toggle()
            }
            Button ("Main") {exercise.tag = "main"
                updater.toggle()
            }
            Button ("Cooldown") {
                exercise.tag = "cooldown"
                updater.toggle()
                
            }
        }
    }
}
