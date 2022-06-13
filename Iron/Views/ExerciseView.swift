//
//  excerciseEntryView.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//

import SwiftUI

struct ExerciseView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var exercises: FetchedResults<Exercise>
    
    @State private var showingSheet = false
    @State private var exerciseArray: [Exercise]
    
    init( exerciseArray: [Exercise]) {
        //_fetchRequest = FetchRequest<Exercise>(sortDescriptors: [], predicate: NSPredicate(format: "name ==%@", filter))
        self._exerciseArray = State(initialValue:exerciseArray)
    }
    var body: some View {
        VStack {
            List {
                ForEach (exerciseArray, id: \.self) { exercise in
                    NavigationLink (destination:SetView(eSetArray: exercise.eSetArray)) {
                        Text(exercise.wrappedName)
                    }
                    
                }
            }
            
        }
        .navigationTitle("Exercises")
        .sheet(isPresented: $showingSheet) {
            AddExerciseView(exercise: exerciseArray[0])
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("New Exercise") {
                    showingSheet.toggle()
                }
            }
        }
    }
    func removeExercise(at offsets: IndexSet) {
        for index in offsets {
            let set = exerciseArray[index]
            moc.delete(set)
            exerciseArray.remove(atOffsets: offsets)
            PersistenceController.shared.save()
        }
    }
    
}
//
//struct excerciseEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseEntryView()
//    }
//}

