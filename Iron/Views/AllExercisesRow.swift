//
//  AllExercisesRow.swift
//  Iron
//
//  Created by Nick Schwab on 7/6/22.
//

import SwiftUI

struct AllExercisesRow: View {
    @AppStorage("defaultReps") private var defaultReps = "5"
    @AppStorage("defaultWeight") private var defaultWeight = "45"
    @AppStorage("defaultRPE") private var defaultRPE = "7"
    @AppStorage("defaultRIR") private var defaultRIR = "2"
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var exercise: Exercise
    
    let viewState: AllExercisesState
    let workout: Workout?
    
    @Binding var isPresented: Bool
    
    init(_ exercise: Exercise, _ viewState: AllExercisesState,_ workout: Workout, _ isPresented: Binding<Bool>) {
        self.exercise = exercise
        self.viewState = viewState
        self.workout = workout
        self._isPresented = isPresented
    }
    
    var body: some View {
        switch viewState {
        case .add:
            Button("\(exercise.strName)") {addExercise(exercise)}
        case .view:
            NavigationLink(destination: Text(exercise.strName)) {
                Text(exercise.strName)
            }
        }
        
    }
    
    func addExercise (_ exercise: Exercise) {
        let newExercise = ExerciseEntity(context: moc)
        newExercise.exercise = exercise
        newExercise.name = exercise.strName
        newExercise.workout = workout
        newExercise.id = UUID()
        newExercise.category = workout?.exerciseCategories[1]
        let defaultSet = ESet(context: moc)
        defaultSet.exerciseEntity = newExercise
        defaultSet.set = 1
        defaultSet.weight = defaultWeight
        defaultSet.reps = defaultReps
        defaultSet.rpe = defaultRPE
        defaultSet.rir = defaultRIR
        defaultSet.isComplete = false
        
        PersistenceController.shared.save()
        isPresented = false
    }
}
