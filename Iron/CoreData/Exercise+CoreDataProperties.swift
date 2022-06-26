//
//  Exercise+CoreDataProperties.swift
//  Iron
//
//  Created by Nick Schwab on 6/6/22.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var workout: Workout?
    @NSManaged public var id: UUID?
    
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
}

// MARK: Generated accessors for eSet
extension Exercise {

    @objc(addESetObject:)
    @NSManaged public func addToESet(_ value: ESet)

    @objc(removeESetObject:)
    @NSManaged public func removeFromESet(_ value: ESet)

    @objc(addESet:)
    @NSManaged public func addToESet(_ values: NSSet)

    @objc(removeESet:)
    @NSManaged public func removeFromESet(_ values: NSSet)

}

extension Exercise : Identifiable {

}
