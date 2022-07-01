//
//  ExerciseEntity+CoreDataProperties.swift
//  Iron
//
//  Created by Nick Schwab on 6/30/22.
//
//

import Foundation
import CoreData

extension ExerciseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseEntity> {
        return NSFetchRequest<ExerciseEntity>(entityName: "ExerciseEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var workout: Workout?
    @NSManaged public var exercise: Exercise?

    
    @NSManaged public var name: String?
        public var wrappedName: String {
            get {name ?? "Unknown Name"}
            set {name = newValue}
        }
        
        @NSManaged public var notes: String?
        public var strNotes: String {
            get {notes ?? ""}
            set {notes = newValue}
        }
        @NSManaged public var eSet: NSSet?
        public var eSetArray: [ESet] {
                let set = eSet as? Set<ESet> ?? []
                return set.sorted{
                    $0.set < $1.set
                }
        }
        
        @NSManaged public var tag: String?
        public var strTag: String {
            get { tag ?? "main" }
            set { tag = newValue }
        }
}

// MARK: Generated accessors for eSet
extension ExerciseEntity {

    @objc(addESetObject:)
    @NSManaged public func addToESet(_ value: ESet)

    @objc(removeESetObject:)
    @NSManaged public func removeFromESet(_ value: ESet)

    @objc(addESet:)
    @NSManaged public func addToESet(_ values: NSSet)

    @objc(removeESet:)
    @NSManaged public func removeFromESet(_ values: NSSet)

}

extension ExerciseEntity : Identifiable {

}
