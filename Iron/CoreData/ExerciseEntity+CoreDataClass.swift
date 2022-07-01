//
//  Exercise+CoreDataClass.swift
//  Iron
//
//  Created by Nick Schwab on 6/6/22.
//
//

import Foundation
import CoreData

@objc(ExerciseEntity)
public class ExerciseEntity: NSManagedObject {

}

extension ExerciseEntity {
    //@NSManaged public var name: String?
        public var wrappedName: String {
            get {name ?? "Unknown Name"}
            set {name = newValue}
        }
        
        //@NSManaged public var notes: String?
        public var strNotes: String {
            get {notes ?? ""}
            set {notes = newValue}
        }
       // @NSManaged public var eSet: NSSet?
        public var eSetArray: [ESet] {
                let set = eSet as? Set<ESet> ?? []
                return set.sorted{
                    $0.set < $1.set
                }
        }
        
        //@NSManaged public var tag: String?
        public var strTag: String {
            get { tag ?? "main" }
            set { tag = newValue }
        }
}
