//
//  CalendarFilter.swift
//  Iron
//
//  Created by Nick Schwab on 7/9/22.
//

import SwiftUI

struct CalendarFilter: View {
    @FetchRequest var fetchRequest: FetchedResults<Workout>
    
    init(startDate: NSDate, endDate: NSDate) {
        _fetchRequest = FetchRequest<Workout>(sortDescriptors: [SortDescriptor(\.date, order: .reverse)], predicate: NSPredicate(format: "(date >= %@) AND (date <= %@)", startDate, endDate))
    }
    var body: some View {
        List(fetchRequest, id: \.self) { workout in
            WorkoutRow(workout)
            
        }
    }
    
}
