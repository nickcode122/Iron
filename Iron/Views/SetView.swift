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
    @State var titles = ["Set","Reps","Weight","RPE","Done"]
    @State var test = ""
    @State var textboxBinding = ""
    @State var isComplete = false
    
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
        .navigationTitle(exercise.eSetArray[0].exercise?.wrappedName ?? "Unknown Exercise Name")
        
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
        let count = exercise.eSetArray.count
        let lastSet = exercise.eSetArray[count - 1]
        
        newSet.set = Int16(count + 1)
        
        newSet.reps = lastSet.reps
        newSet.weight = lastSet.weight
        newSet.rpe = lastSet.rpe
        newSet.isComplete = false
        newSet.exercise = exercise.eSetArray[0].exercise
        PersistenceController.shared.save()
    }
}
