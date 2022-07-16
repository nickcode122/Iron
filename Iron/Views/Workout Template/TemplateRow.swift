//
//  TemplateRow.swift
//  Iron
//
//  Created by Nick Schwab on 7/16/22.
//

import SwiftUI

struct TemplateRow: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var template: WorkoutTemplate
    
    @State private var showConfirmation = false
    
    init(_ template: WorkoutTemplate) {
        self.template = template
    }
    
    var body: some View {
        NavigationLink(destination: TemplateDetailView(template)) {
            Text(template.wrappedName)
        }
        .swipeActions {
            DeleteButton(showDeletePrompt)
            PencilEditButton(edit)
        }
        .confirmationDialog("Delete \(template.wrappedName)", isPresented: $showConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive, action: delete)
        }
    }
    
    private func showDeletePrompt() {
        showConfirmation.toggle()
    }
    private func delete() {
        moc.delete(template)
        PersistenceController.shared.save()
    }
    
    private func edit() {
        
    }
    
}
