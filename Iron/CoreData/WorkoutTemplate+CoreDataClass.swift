//
//  WorkoutTemplate+CoreDataClass.swift
//  Iron
//
//  Created by Nick Schwab on 7/10/22.
//
//

import Foundation
import CoreData

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
}
