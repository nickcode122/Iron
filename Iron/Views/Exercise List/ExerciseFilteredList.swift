//
//  ExerciseFilteredList.swift
//  Iron
//
//  Created by Nick Schwab on 7/6/22.
//

import SwiftUI

struct ExerciseFilteredList: View {
    @FetchRequest var fetchRequest: FetchedResults<Exercise>
    
    init(filter: String) {
        if (filter == "") {
            _fetchRequest = FetchRequest<Exercise>(sortDescriptors: [SortDescriptor(\.name)])
        } else {
            _fetchRequest = FetchRequest<Exercise>(sortDescriptors: [], predicate: NSPredicate(format: "name CONTAINS %@", filter))
        }
    }
    
    var body: some View {
        List(fetchRequest, id: \.name) { exercise in
            ExerciseFilteredListRow(exercise)
        }
    }
}
