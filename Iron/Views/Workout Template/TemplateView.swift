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
            VStack(spacing: 10) {
                Form {
                    List(templates, id: \.self) { template in
                        Text(template.wrappedName)
                    }
                    createTemplateButton
                    
                        .sheet(isPresented: $showSheet) {
                            NewTemplateView()
                        }
                }
            }
            .navigationBarTitle("Workout Templates", displayMode: .inline)
        }


        
    }
    private var createTemplateButton: some View {
        Button("Create Workout Template", action: createTemplate)
    }
    
    func createTemplate() {
        showSheet.toggle()
    }
}
