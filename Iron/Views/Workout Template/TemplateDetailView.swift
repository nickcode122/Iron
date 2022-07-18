//
//  TemplateDetailView.swift
//  Iron
//
//  Created by Nick Schwab on 7/10/22.
//

import SwiftUI

struct TemplateDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject private var viewRouter: ViewRouter
    
    @ObservedObject public var template: WorkoutTemplate
    @State public var showSheet = false
    @State private var showLogPrompt = false
    @State private var logName: String?
    
    
    init(_ template: WorkoutTemplate) {
        self.template = template
    }
    var body: some View {
        Form {
            List {
                ForEach(template.exercises, id: \.self) {exercise in
                    ExerciseRow(exercise)
                }
                .onMove(perform: move)
            }
            Section {
                Button("Add Exercise", action: showAddExerciseView)
                Button("Use Template", action: showLogNamePrompt)
            }
        }
        .navigationBarTitle(template.wrappedName, displayMode: .inline)
        .sheet(isPresented: $showSheet) {
            AddExerciseView(template, dismiss: $showSheet)
        }
        .toolbar {
            EditButton()
        }
        .textFieldAlert(isPresented: $showLogPrompt) { () -> TextFieldAlert in
            TextFieldAlert(title: "Use Template", message: "Enter a name", text: self.$logName, action: createLog)
        }
    }
    private func showAddExerciseView() {
        showSheet.toggle()
    }
    private func move(from source: IndexSet, to destination: Int) {
        var revisedItems: [ExerciseEntity] = template.exercises
        revisedItems.move(fromOffsets: source, toOffset: destination)
        
        for reverseIndex in stride(from: revisedItems.count - 1, through: 0, by: -1) {
            revisedItems[reverseIndex].userOrder = Int16(reverseIndex)
        }
        //forces a change to the observed template, causing the list to update immediately
        template.id = UUID()
        PersistenceController.shared.save()
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        for index in offsets {
            let exercise = template.exercises[index]
            moc.delete(exercise)
        }
        PersistenceController.shared.save()
    }
    
    private func showLogNamePrompt() {
        showLogPrompt.toggle()
    }
    
    private func createLog() {
        let newWorkout = template.copyToLog(logName ?? "Error", context: moc)
        viewRouter.newWorkout = newWorkout
        viewRouter.currentView = .logs
        viewRouter.workoutLinkActive = true
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Previewing(\.template) { template in
                TemplateDetailView(template)
            }
        }
    }

}
