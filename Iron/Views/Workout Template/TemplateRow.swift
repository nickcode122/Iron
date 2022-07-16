//
//  TemplateRow.swift
//  Iron
//
//  Created by Nick Schwab on 7/16/22.
//

import SwiftUI

struct TemplateRow: View {
    
    @ObservedObject var template: WorkoutTemplate
    
    init(_ template: WorkoutTemplate) {
        self.template = template
    }
    
    var body: some View {
        NavigationLink(destination: TemplateDetailView(template)) {
            Text(template.wrappedName)
        }
        .swipeActions {
            deleteButton(action: delete)
            editButton
        }
    }
    
    private var editButton: some View {
        Button(action: edit) {
            Label("Edit", systemImage: "pencil")
        }
    }
    
    private func delete() {
        
    }
    
    private func edit() {
        
    }
}
