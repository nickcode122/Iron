//
//  TemplateDetailView.swift
//  Iron
//
//  Created by Nick Schwab on 7/10/22.
//

import SwiftUI

struct TemplateDetailView: View {
    @ObservedObject private var template: WorkoutTemplate
    
    var body: some View {
        Form {
            Text("Exercises").font(.largeTitle)
            List {
                ForEach(template.exercises, id: \.self) {exercise in
                    Text(exercise.wrappedName)
                }
            }
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        var revisedItems: [ExerciseEntity] = template.exercises
        revisedItems.move(fromOffsets: source, toOffset: destination)
        
        for reverseIndex in stride(from: revisedItems.count - 1, through: 0, by: -1) {
            revisedItems[reverseIndex].userOrder = Int16(reverseIndex)
        }
        //forces a change to the observed template, causing the list to update immediately
        template.id = UUID()
        PersistenceController.shared.save()
    }
}
