//
//  excerciseEntryView.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//

import SwiftUI

struct ExerciseEntryView: View {
    @Environment(\.managedObjectContext) var moc
    
    //Likely sort down fetch request to particular exercise
    @FetchRequest(sortDescriptors: []) var exercises: FetchedResults<Exercise>
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)],
//                  predicate: NSPredicate(format: "name ==%@", "Pullup"))
//    var exercises: FetchedResults<Exercise>
    
    @State private var showingAddSetScreen = false
    
    @State private var exerciseArray: [Exercise]
    
    init( exerciseArray: [Exercise]) {
        //_fetchRequest = FetchRequest<Exercise>(sortDescriptors: [], predicate: NSPredicate(format: "name ==%@", filter))
        self._exerciseArray = State(initialValue:exerciseArray)
    }
    var body: some View {
            VStack {
                List {
                    ForEach (exerciseArray, id: \.self) { exercise in
                        NavigationLink (destination:AddSetView(eSetArray: exercise.eSetArray)) {
                            Text(exercise.wrappedName)
                        }
                        
                    }
                }
                
            }
            .navigationTitle("Exercises")
    }
    
}
//
//struct excerciseEntryView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseEntryView()
//    }
//}

