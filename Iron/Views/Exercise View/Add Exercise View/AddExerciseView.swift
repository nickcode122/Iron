//
//  AllExercisesView.swift
//  Iron
//
//  Created by Nick Schwab on 6/16/22.
//

import CoreData
import SwiftUI

public enum AddView {
    case workout, template, error
}
struct AddExerciseView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var exercises: FetchedResults<Exercise>
    @Environment(\.managedObjectContext) var moc
    
    @State private var searchText = ""
    @Binding public var dismiss: Bool
    
    public let workout: Workout
    public let template: WorkoutTemplate
    @State var viewMode: AddView = .error
    
    init(_ workout: Workout, dismiss: Binding<Bool>) {
        self.workout = workout
        self._dismiss = dismiss
        self.template = WorkoutTemplate()
        self._viewMode = State(initialValue: .workout)
    }
    
    init(_ template: WorkoutTemplate, dismiss: Binding<Bool>) {
        self.template = template
        self.workout = Workout()
        self._dismiss = dismiss
        self._viewMode = State(initialValue: .template)
    }
    var body: some View {
        NavigationView {
            List(searchResults, id: \.self) { exercise in
                switch viewMode {
                case .workout:
                    AddExerciseRow(workout, exercise, $dismiss)
                case .template:
                    AddExerciseRow(template, exercise, $dismiss)
                default:
                    Text("Something went wrong")
                }
            }
            .searchable(text:$searchText, placement: .navigationBarDrawer(displayMode: .always))
            .navigationTitle("Add Exercise")
        }
    }
    var searchResults: [Exercise] {
        let exerciseArray: [Exercise] = exercises.map { $0 }
        if searchText.isEmpty {
            return exerciseArray
        } else {
            return exerciseArray.filter { $0.strName.contains(searchText)}
        }
    }
}
