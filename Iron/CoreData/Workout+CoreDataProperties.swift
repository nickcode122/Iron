//
//  Workout+CoreDataProperties.swift
//  Iron
//
//  Created by Nick Schwab on 6/30/22.
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
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    @NSManaged public var notes: String?
    public var strNotes: String {
        get {notes ?? ""}
        set {notes = newValue}
    }
    
    @NSManaged public var exerciseEntity: NSSet?
    
    public var exerciseArray: [ExerciseEntity] {
        let set = exerciseEntity as? Set<ExerciseEntity> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    @NSManaged public var date: Date?
    public var wrappedDate: Date {
        get { date ?? Date() }
    }

}

// MARK: Generated accessors for exerciseEntity
extension Workout {

    @objc(addExerciseEntityObject:)
    @NSManaged public func addToExerciseEntity(_ value: ExerciseEntity)

    @objc(removeExerciseEntityObject:)
    @NSManaged public func removeFromExerciseEntity(_ value: ExerciseEntity)

    @objc(addExerciseEntity:)
    @NSManaged public func addToExerciseEntity(_ values: NSSet)

    @objc(removeExerciseEntity:)
    @NSManaged public func removeFromExerciseEntity(_ values: NSSet)

}

extension Workout : Identifiable {

}
