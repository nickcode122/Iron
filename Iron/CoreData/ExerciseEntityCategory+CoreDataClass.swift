//
//  ExerciseEntityCategory+CoreDataClass.swift
//  Iron
//
//  Created by Nick Schwab on 7/1/22.
//
//

import Foundation
import CoreData

@objc(ExerciseEntityCategory)
public class ExerciseEntityCategory: NSManagedObject {

}

extension ExerciseEntityCategory {
    
    //@NSManaged public var name: String?
    public var strName: String {
        get { name ?? "Unknown Category"}
        set { name = newValue }
    }
    
    //@NSManaged public var exerciseEntityCategory: NSSet?
    public var exerciseEntities: [ExerciseEntity] {
        let set = exerciseEntity as? Set<ExerciseEntity> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
