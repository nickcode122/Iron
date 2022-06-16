//
//  SetView.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//
import CoreData
import SwiftUI

struct SetView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    private let titles = ["Set","Reps","Weight","RPE","Done"]
    
    @ObservedObject var exercise: Exercise
    var body: some View {
        
        VStack {
            Form {
                Section {
                    HStack {
                        ForEach(titles, id: \.self) { title in
                            Text(title)
                                .frame(width: 60, alignment: .center)
                        }
                    }
                    .font(Font.headline)
                    
                    List {
                        ForEach(exercise.eSetArray, id: \.self) {eSet in
                            ESetTextfieldView(eSet: eSet)
                            .multilineTextAlignment(.center)
                            .toggleStyle(CheckboxStyle())
                            .keyboardType(.decimalPad)
                        }
                        .onDelete(perform: removeRows)
                    }
                }
                Button("Add Set") {
                    addSet()
                }
                Button("Save") {
                    PersistenceController.shared.save()
                }
            }

        }
        .navigationTitle(exercise.wrappedName)
        
    }
    func removeRows(at offsets: IndexSet) {
        for index in offsets {
            let set = exercise.eSetArray[index]
            moc.delete(set)
            PersistenceController.shared.save()
        }
        
    }
    func addSet() {
        let newSet = ESet(context: moc)
        let setCount = exercise.eSetArray.count
        
        if setCount > 0 { //If there is a previous set to copy, copy it
            let lastSet = exercise.eSetArray[setCount - 1]
            newSet.reps = lastSet.reps
            newSet.weight = lastSet.weight
            newSet.rpe = lastSet.rpe
        } else { // otherwise use default values
            newSet.reps = "5"
            newSet.weight = "45.0"
            newSet.rpe = "7"
        }
        
        newSet.set = Int16(setCount + 1)
        newSet.isComplete = false
        newSet.exercise = exercise.eSetArray[0].exercise
        PersistenceController.shared.save()
    }
}
