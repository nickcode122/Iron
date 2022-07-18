//
//  AddExerciseRow.swift
//  Iron
//
//  Created by Nick Schwab on 7/6/22.
//

import SwiftUI

struct AddExerciseRow: View {
    @AppStorage("defaultReps") private var defaultReps = "5"
    @AppStorage("defaultWeight") private var defaultWeight = "45"
    @AppStorage("defaultRPE") private var defaultRPE = "7"
    @AppStorage("defaultRIR") private var defaultRIR = "2"
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var exercise: Exercise
    @State private var showingConfirmation = false
    @State private var showingSheet = false
    public let workout: Workout
    public let template: WorkoutTemplate
    @Binding var dismiss: Bool
    
    @State var viewMode: AddView = .error
    
    init(_ workout: Workout, _ exercise: Exercise, _ dismiss: Binding<Bool>) {
        self.exercise = exercise
        self.workout = workout
        self._dismiss = dismiss
        self.template = WorkoutTemplate()
        self._viewMode = State(initialValue: .workout)
    }
    
    init(_ template: WorkoutTemplate, _ exercise: Exercise, _ dismiss: Binding<Bool>) {
        self.exercise = exercise
        self.workout = Workout()
        self.template = template
        self._dismiss = dismiss
        self._viewMode = State(initialValue: .template)
    }
    
    var body: some View {
        Button("\(exercise.strName)", action: addExercise)
            .swipeActions {
                deleteButton
                editButton
            }
            .confirmationDialog("Confirm Delete", isPresented: $showingConfirmation, titleVisibility: .visible) {
                confirmDeleteButton
            }
            .sheet(isPresented: $showingSheet) {
                EditExerciseView(exercise)
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
        showingSheet.toggle()
    }
    
    func addExercise () {
        let newExercise = ExerciseEntity(context: moc)
        newExercise.exercise = exercise
        newExercise.name = exercise.strName
        newExercise.id = UUID()
        
        switch viewMode {
        case .template:
            newExercise.workoutTemplate = template
            newExercise.userOrder = Int16(template.exercises.count + 1)
        case .workout:
            newExercise.workout = workout
            newExercise.userOrder = Int16( workout.exerciseArray.count + 1)
        case .error:
            return
        }
        let defaultSet = ESet(context: moc)
        defaultSet.exerciseEntity = newExercise
        defaultSet.set = 1
        defaultSet.weight = defaultWeight
        defaultSet.reps = defaultReps
        defaultSet.rpe = defaultRPE
        defaultSet.rir = defaultRIR
        defaultSet.isComplete = false
        
        PersistenceController.shared.save()
        dismiss.toggle()
    }
    
    func addToTemplate() {
        
    }
}
