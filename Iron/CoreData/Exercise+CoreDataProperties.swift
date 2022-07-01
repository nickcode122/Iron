//
//  Exercise+CoreDataProperties.swift
//  Iron
//
//  Created by Nick Schwab on 6/30/22.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }


    @NSManaged public var exerciseEntity: NSSet?
    
    @NSManaged public var name: String?
    public var strName: String {
        get {name ?? "Unknown Name"}
        set {name = newValue}
    }

}

// MARK: Generated accessors for exerciseEntity
extension Exercise {

    @objc(addExerciseEntityObject:)
    @NSManaged public func addToExerciseEntity(_ value: ExerciseEntity)

    @objc(removeExerciseEntityObject:)
    @NSManaged public func removeFromExerciseEntity(_ value: ExerciseEntity)

    @objc(addExerciseEntity:)
    @NSManaged public func addToExerciseEntity(_ values: NSSet)

    @objc(removeExerciseEntity:)
    @NSManaged public func removeFromExerciseEntity(_ values: NSSet)

}

extension Exercise : Identifiable {

}
