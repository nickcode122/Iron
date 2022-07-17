//
//  WorkoutTemplate+CoreDataClass.swift
//  Iron
//
//  Created by Nick Schwab on 7/10/22.
//
//

import Foundation
import CoreData
import SwiftUI


@objc(WorkoutTemplate)
public class WorkoutTemplate: NSManagedObject {
}

extension WorkoutTemplate {
    //@NSManaged public var name: String?
    public var wrappedName: String {
        get { name ?? "Unknown Name" }
        set { name = newValue }
    }
    
    //@NSManaged public var exerciseEntity: NSSet?
    public var exercises: [ExerciseEntity] {
        let set = exerciseEntity as? Set<ExerciseEntity> ?? []
        return set.sorted {
            $0.userOrder < $1.userOrder
        }
    }
    
    
    /// Creates a workout from the template
    /// - Parameters:
    ///   - logName: Name for the logged workout
    ///   - moc: Managed Object Context
    public func copyToLog(_ logName: String, context moc: NSManagedObjectContext) {
        let newLog = Workout(context: moc)
        newLog.name = logName
        newLog.date = Date()
        newLog.id = UUID()
        
        for exercise in exercises {
            let newExercise = ExerciseEntity(context: moc)
            newExercise.id = UUID()
            newExercise.name = exercise.wrappedName
            newExercise.notes = exercise.notes
            newExercise.userOrder = exercise.userOrder
            
            for eset in exercise.eSetArray {
                let newSet = ESet(context: moc)
                
                newSet.reps = eset.reps
                newSet.rpe = eset.rpe
                newSet.rir = eset.rir
                newSet.set = eset.set
                newSet.weight = eset.weight
                newSet.isComplete = false
                
                newSet.exerciseEntity = newExercise
            }
            newExercise.workout = newLog
        }
        PersistenceController.shared.save()
    }
}
