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
    
    @AppStorage("defaultReps") private var defaultReps = "5"
    @AppStorage("defaultWeight") private var defaultWeight = "45"
    @AppStorage("defaultRPE") private var defaultRPE = "7"
    @AppStorage("defaultRIR") private var defaultRIR = "2"
    @AppStorage("useLastSetValues") private var useLastSetValues = true
    
    @ObservedObject var exercise: Exercise
    var body: some View {
        VStack {
            Form {
                Section {
                    ESetTitleView()
                    List {
                        ForEach(exercise.eSetArray, id: \.self) {eSet in
                            ESetTextfieldView(eSet: eSet)
                                .multilineTextAlignment(.center)
                                .toggleStyle(CheckboxStyle())
                                .keyboardType(.decimalPad)
                                .submitLabel(.next)
                        }
                        .onDelete(perform: removeESet)
                    }
                }
                Button("Add Set") {
                    addSet()
                }
                Section("Notes") {
                    TextEditor(text: $exercise.strNotes)
                        .frame(height: 150, alignment: .topLeading)
                        .submitLabel(.done)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                Button("Done") {
                                    UIApplication.shared.endEditing()
                                }

                            }
                        }
                }
            }
            
        }
        .navigationTitle(exercise.wrappedName)

    }
    
    func removeESet(at offsets: IndexSet) {
        for index in offsets {
            let set = exercise.eSetArray[index]
            moc.delete(set)
            PersistenceController.shared.save()
            renumberSets()
        }
    }
    func renumberSets() {
        var count: Int16 = 1
        for eSet in exercise.eSetArray {
            eSet.set = count
            count += 1
        }
        PersistenceController.shared.save()
    }
    
    func addSet() {
        let newSet = ESet(context: moc)
        let setCount = exercise.eSetArray.count
        
        if setCount > 0 && useLastSetValues {
            let lastSet = exercise.eSetArray[setCount - 1]
            newSet.reps = lastSet.reps
            newSet.weight = lastSet.weight
            newSet.rpe = lastSet.rpe
            newSet.rir = lastSet.rir
        } else {
            newSet.reps = defaultReps
            newSet.weight = defaultWeight
            newSet.rpe = defaultRPE
            newSet.rir = defaultRIR
            
        }
        
        newSet.set = Int16(setCount + 1)
        newSet.isComplete = false
        newSet.exercise = exercise
        PersistenceController.shared.save()
    }
}


