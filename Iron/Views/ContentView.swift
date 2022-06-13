//
//  ContentView.swift
//  Iron
//
//  Created by Nick Schwab on 6/1/22.
//
import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    //@FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)],
                  predicate: NSPredicate(format: "name ==%@", "Workout 1"))
    var workouts: FetchedResults<Workout>
    var body: some View {
        
        NavigationView {
        WorkoutView()
        }

    }
    func addTestData() {
        let workout1 = Workout(context: moc)
        workout1.name = "Workout 1"
        workout1.id = UUID()

        let workout2 = Workout(context: moc)
        workout2.name = "Workout 2"
        workout2.id = UUID()

        let exercise1 = Exercise(context: moc)
        exercise1.name = "Pullups"
        exercise1.workout = workout1

        let exercise2 = Exercise(context: moc)
        exercise2.name = "Bench Press"
        exercise2.workout = workout1

        let exercise3 = Exercise(context: moc)
        exercise3.name = "Squat"
        exercise3.workout = workout2

        let set1 = ESet(context: moc)
        set1.set = 1
        set1.weight = 45
        set1.rpe = 8
        set1.reps = 10
        set1.exercise = exercise1

        let set2 = ESet(context: moc)
        set2.set = 2
        set2.weight = 45
        set2.rpe = 8
        set2.reps = 10
        set2.exercise = exercise1

        let set3 = ESet(context: moc)
        set3.set = 1
        set3.weight = 45
        set3.rpe = 8
        set3.reps = 3
        set3.exercise = exercise2

        let set4 = ESet(context: moc)
        set4.set = 1
        set4.weight = 200
        set4.rpe = 9
        set4.reps = 5
        set4.exercise = exercise3

        let set5 = ESet(context: moc)
        set5.set = 2
        set5.weight = 250
        set5.rpe = 10
        set5.reps = 4
        set5.exercise = exercise3

        PersistenceController.shared.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
