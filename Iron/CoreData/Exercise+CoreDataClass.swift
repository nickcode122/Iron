//
//  Exercise+CoreDataClass.swift
//  Iron
//
//  Created by Nick Schwab on 6/30/22.
//
//

import Foundation
import CoreData

@objc(Exercise)
public class Exercise: NSManagedObject {
    
    

}
extension Exercise {
    //@NSManaged public var name: String?
    public var strName: String {
        get {name ?? "Unknown Name"}
        set {name = newValue}
    }
}
