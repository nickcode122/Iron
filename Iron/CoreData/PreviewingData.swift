//
//  PreviewingData.swift
//  Iron
//
//  Created by Nick Schwab on 7/15/22.
//

import CoreData
import SwiftUI

struct PreviewingData {
    var workouts: (NSManagedObjectContext) -> [Workout] {  {context in
        var createdWorkouts = [Workout]()
        for n in 0..<5 {
            let newWorkout = Workout(context: context)
            newWorkout.name = "Workout \(n)"
            newWorkout.date = Date.now
            newWorkout.id = UUID()
            createdWorkouts.append(newWorkout)
        }
        return createdWorkouts
    }}
    var templates: (NSManagedObjectContext) -> [WorkoutTemplate] {  {context in
        var createdTemplates = [WorkoutTemplate]()
        for n in 0..<5 {
            let newTemplate = WorkoutTemplate(context: context)
            newTemplate.name = "Template \(n)"
            newTemplate.id = UUID()
            createdTemplates.append(newTemplate)
        }
        return createdTemplates
    }}
    
    
    var workout: (NSManagedObjectContext) -> Workout { { context in
        let newWorkout = Workout(context: context)
        newWorkout.name = "Workout"
        newWorkout.date = Date.now
        newWorkout.id = UUID()
        return newWorkout
    }}
    
    var template: (NSManagedObjectContext) -> WorkoutTemplate { { context in
        let newTemplate = WorkoutTemplate(context: context)
        newTemplate.name = "Workout"
        newTemplate.id = UUID()
        
        let exercise = ExerciseEntity(context: context)
        exercise.workoutTemplate = newTemplate
        exercise.name = "Example Exercise Entry"
        return newTemplate
    }}
}


