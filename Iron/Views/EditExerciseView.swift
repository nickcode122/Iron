//
//  EditExerciseView.swift
//  Iron
//
//  Created by Nick Schwab on 7/5/22.
//

import SwiftUI

struct EditExerciseView: View {
    @ObservedObject var exercise: Exercise
    
    init(_ exercise: Exercise) {
        self.exercise = exercise
    }
    
    var body: some View {
        Text(exercise.strName)
    }
}
