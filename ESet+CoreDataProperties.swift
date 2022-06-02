//
//  ESet+CoreDataProperties.swift
//  Iron
//
//  Created by Nick Schwab on 6/1/22.
//
//

import Foundation
import CoreData


extension ESet {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ESet> {
        return NSFetchRequest<ESet>(entityName: "ESet")
    }

    @NSManaged public var category: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var reps: Int16
    @NSManaged public var rpe: Int16
    @NSManaged public var time: Date?
    @NSManaged public var weight: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var origin: Exercise?
    
    public var wrappedCategory: String {
        category ?? "Unknown Category"
    }
    

}

extension ESet : Identifiable {

}
