//
//  TemplateRow.swift
//  Iron
//
//  Created by Nick Schwab on 7/16/22.
//

import SwiftUI

struct TemplateRow: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject private var viewRouter: ViewRouter
    @ObservedObject var template: WorkoutTemplate
    
    @State private var showConfirmation = false
    
    @State private var showSheet = false
    @State private var newName: String?
    
    @State private var showLogPrompt = false
    @State private var logName: String?
    
    init(_ template: WorkoutTemplate) {
        self.template = template
    }
    
    var body: some View {
        NavigationLink(destination: TemplateDetailView(template)) {
            Text(template.wrappedName)
                .textFieldAlert(isPresented: $showSheet) { () -> TextFieldAlert in
                    TextFieldAlert(title: "Edit Template Name", message: "Enter a new name", text: self.$newName, action: editTemplate)
                }
                .textFieldAlert(isPresented: $showLogPrompt) { () -> TextFieldAlert in
                    TextFieldAlert(title: "Use Template", message: "Enter a name", text: self.$logName, action: createLog)
                }
        }
        .swipeActions(edge: .trailing) {
            DeleteButton(showDeletePrompt)
            PencilEditButton(showEditPrompt)
        }
        .swipeActions(edge: .leading) {
            copyTemplateButton
        }
        .confirmationDialog("Delete \(template.wrappedName)", isPresented: $showConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive, action: delete)
        }

    }
    
    private var copyTemplateButton: some View {
        Button {showLogPrompt.toggle()} label: {
            Label("Copy", systemImage: "doc.on.doc.fill")
        }
    }
    private func showDeletePrompt() {
        showConfirmation.toggle()
    }
    private func delete() {
        moc.delete(template)
        PersistenceController.shared.save()
    }
    
    private func showEditPrompt() {
        newName = template.wrappedName
        showSheet.toggle()
    }
    private func editTemplate() {
        template.name = newName
        PersistenceController.shared.save()
    }
    
    private func createLog() {
        let newWorkout = template.copyToLog(logName ?? "Error", context: moc)
        viewRouter.newWorkout = newWorkout
        viewRouter.currentView = .logs
        viewRouter.workoutLinkActive = true
    }
    
}
