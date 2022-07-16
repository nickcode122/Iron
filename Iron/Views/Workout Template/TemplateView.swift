//
//  TemplateView.swift
//  Iron
//
//  Created by Nick Schwab on 7/10/22.
//

import SwiftUI

struct TemplateView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var templates: FetchedResults<WorkoutTemplate>
    
    @State private var showSheet = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.pink
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
                        
                        
                        .sheet(isPresented: $showSheet) {
                            NewTemplateView()
                        }
                    }
                }
            }
            .navigationBarTitle("Workout Templates", displayMode: .inline)
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
        Button("Create Workout Template", action: createTemplate)
    }
    
    func createTemplate() {
        showSheet.toggle()
    }
}
