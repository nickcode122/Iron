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
        if noWorkouts {
            Text("No workouts found")
        }
        List(fetchRequest, id: \.self) { workout in
            WorkoutRow(workout)
            
        }
    }
    
    private var noWorkouts: Bool {
        fetchRequest.isEmpty
    }
    
//    struct ContentView_Previews: PreviewProvider {
//        static var previews: some View {
//            Previewing(contextWith: \.workouts) {
//                CalendarFilter(startDate: Date() as NSDate, endDate:  Date() as NSDate )
//            }
//        }
//
//    }

}
