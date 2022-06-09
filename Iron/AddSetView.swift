//
//  addSetView.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//
import CoreData
import SwiftUI

struct AddSetView: View {
    
    //@FetchRequest var fetchRequest: FetchedResults<Exercise>
    @Environment(\.managedObjectContext) var moc
    @State var titles = ["Set","Reps","Weight","RPE","Done"]
    @State var test = ""
    @State var textboxBinding = ""
    @State var isComplete = false
    
    @State var eSetArray: [ESet]
    
    init( eSetArray: [ESet]) {
        //_fetchRequest = FetchRequest<Exercise>(sortDescriptors: [], predicate: NSPredicate(format: "name ==%@", filter))
        self._eSetArray = State(initialValue:eSetArray)
        
    }
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
                        ForEach($eSetArray, id: \.self) {$eSet in
                            HStack {
                                Text(String(eSet.set))
                                    .frame(minWidth: 60, alignment:.center)
                                TextField("1", text: $eSet.strReps)
                                    .frame(minWidth: 60)
                                TextField("1", text: $eSet.strWeight)
                                    .frame(minWidth: 60)
                                TextField("1", text: $eSet.strRpe)
                                    .frame(minWidth: 60)
                                Toggle(isOn: $eSet.isComplete) {}
                                    .frame(minWidth: 60)
                            }
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
        .navigationTitle(eSetArray[0].exercise?.wrappedName ?? "Unknown Exercise Name")
        
    }
    func removeRows(at offsets: IndexSet) {
        

        
        for index in offsets {
            let set = eSetArray[index]
            moc.delete(set)
            eSetArray.remove(atOffsets: offsets)
        }
        
    }
    func addSet() {
        let newSet = ESet(context: moc)
        let count = eSetArray.count
        let lastSet = eSetArray[count - 1]
        
        newSet.set = Int16(count + 1)
        
        newSet.reps = lastSet.reps
        newSet.weight = lastSet.weight
        newSet.rpe = lastSet.rpe
        newSet.isComplete = false
        newSet.exercise = eSetArray[0].exercise
        eSetArray.append(newSet)
    }
}

//struct addSetView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        AddSetView(filter: "")
//    }
//}
