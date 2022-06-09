//
//  ESet+CoreDataProperties.swift
//  Iron
//
//  Created by Nick Schwab on 6/6/22.
//
//

import Foundation
import CoreData


extension ESet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ESet> {
        return NSFetchRequest<ESet>(entityName: "ESet")
    }

    @NSManaged public var set: Int16
    @NSManaged public var rpe: Int16
    @NSManaged public var weight: Double
    @NSManaged public var isComplete: Bool
    @NSManaged public var exercise: Exercise?
    @NSManaged public var reps: Int16
    
    public var strSet: String {
        String(set)
    }
    public var strRpe: String {
        get {String(rpe)}
        set {rpe = Int16(newValue) ?? 0}
    }
    public var strWeight: String {
        get {String(weight)}
        set {weight = Double(newValue) ?? 0}
    }
    public var strReps: String {
        get {String(reps)}
        set {reps = Int16(newValue) ?? 0}
    }
    

}

extension ESet : Identifiable {

}
