//
//  Workout+CoreDataProperties.swift
//  Iron
//
//  Created by Nick Schwab on 6/1/22.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var exercise: NSSet?
    
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var exerciseArray: [Exercise] {
        let set = exercise as? Set<Exercise> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for exercise
extension Workout {

    @objc(addExerciseObject:)
    @NSManaged public func addToExercise(_ value: Exercise)

    @objc(removeExerciseObject:)
    @NSManaged public func removeFromExercise(_ value: Exercise)

    @objc(addExercise:)
    @NSManaged public func addToExercise(_ values: NSSet)

    @objc(removeExercise:)
    @NSManaged public func removeFromExercise(_ values: NSSet)

}

extension Workout : Identifiable {

}
