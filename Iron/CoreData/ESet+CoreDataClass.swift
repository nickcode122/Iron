//
//  ESet+CoreDataClass.swift
//  Iron
//
//  Created by Nick Schwab on 6/6/22.
//
//

import Foundation
import CoreData

@objc(ESet)
public class ESet: NSManagedObject {

}
extension ESet {
    
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
