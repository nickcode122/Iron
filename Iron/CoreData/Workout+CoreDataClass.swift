//
//  Workout+CoreDataClass.swift
//  Iron
//
//  Created by Nick Schwab on 6/6/22.
//
//

import Foundation
import CoreData

@objc(Workout)
public class Workout: NSManagedObject {

}
extension Workout {
    //@NSManaged public var name: String?
    public var wrappedName: String {
        name ?? "Unknown Name"
    }
   // @NSManaged public var notes: String?
    public var strNotes: String {
        get {notes ?? ""}
        set {notes = newValue}
    }
    //@NSManaged public var exerciseEntity: NSSet?
    public var exerciseArray: [ExerciseEntity] {
        let set = exerciseEntity as? Set<ExerciseEntity> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    //@NSManaged public var date: Date?
    public var wrappedDate: Date {
        get { date ?? Date() }
    }
}
