//
//  TemplateView.swift
//  Iron
//
//  Created by Nick Schwab on 7/10/22.
//

import SwiftUI

struct TemplateView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var templates: FetchedResults<WorkoutTemplate>
    
    @State private var showAlert = false
    @State private var templateName: String?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                Form {
                    Text("Templates")
                        .font(.title)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    Section {
                        List(templates, id: \.self) { template in
                            TemplateRow(template)
                        }
                    }
                    .padding(.top, 0)
                    Section {
                        createTemplateButton
                    }
                    
                }
            }
            .navigationBarTitle("Workout Templates", displayMode: .inline)
            .textFieldAlert(isPresented: $showAlert) { () -> TextFieldAlert in
                TextFieldAlert(title: "Create Template", message: "Enter a name", text: self.$templateName, action: createTemplate)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            Previewing(contextWith: \.templates) {
                TemplateView()
            }
        }
    }
    
    private var createTemplateButton: some View {
        Button("Create Workout Template", action: showPrompt)
    }
    
    func showPrompt() {
        showAlert.toggle()
    }
    
    func createTemplate() {
        let template = WorkoutTemplate(context: moc)
        template.name = templateName ?? "Error"
        PersistenceController.shared.save()
    }
}
