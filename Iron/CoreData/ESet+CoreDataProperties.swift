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
    @NSManaged public var rpe: String?
    @NSManaged public var weight: String?
    @NSManaged public var isComplete: Bool
    @NSManaged public var exercise: Exercise?
    @NSManaged public var reps: String?
    @NSManaged public var rir: String?
    
    public var strRir: String {
        get {rir ?? "11"}
        set {self.rir = newValue}
    }

    public var strRpe: String {
        get {rpe ?? "11"}
        set {self.rpe = newValue}
    }
    public var strWeight: String {
        get {weight ?? "111.11"}
        set {self.weight = newValue}
    }
    public var strReps: String {
        get { reps ?? "11"}
        set {self.reps = newValue}
    }
    

}

extension ESet : Identifiable {

}
