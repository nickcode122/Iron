//
//  Exercise+CoreDataProperties.swift
//  Iron
//
//  Created by Nick Schwab on 6/1/22.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var eset: NSSet?
    @NSManaged public var origin: Workout?

    public var wrappedName: String {
        name ?? "Unknown Name"
    }
    
    public var esetArray: [ESet] {
        let set = eset as? Set<ESet> ?? []
        return set.sorted {
            $0.id < $1.id
        }
    }
    
}

// MARK: Generated accessors for eset
extension Exercise {

    @objc(addEsetObject:)
    @NSManaged public func addToEset(_ value: ESet)

    @objc(removeEsetObject:)
    @NSManaged public func removeFromEset(_ value: ESet)

    @objc(addEset:)
    @NSManaged public func addToEset(_ values: NSSet)

    @objc(removeEset:)
    @NSManaged public func removeFromEset(_ values: NSSet)

}

extension Exercise : Identifiable {

}
