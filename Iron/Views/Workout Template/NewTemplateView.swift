//
//  NewTemplateView.swift
//  Iron
//
//  Created by Nick Schwab on 7/10/22.
//

import SwiftUI

struct NewTemplateView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State private var templateName = ""
    @State private var templateDescription = ""
    
    var body: some View {
        Form {
            TextField("Template Name", text: $templateName)
            TextField("Description", text: $templateDescription)
            
            Section {
                Button("Save", action: saveTemplate)
            }
        }
    }
    
    private func saveTemplate() {
        let template = WorkoutTemplate(context: moc)
        template.name = templateName
        template.detail = templateDescription
        PersistenceController.shared.save()
        dismiss()
    }

}
