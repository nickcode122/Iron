//
//  SettingsView.swift
//  Iron
//
//  Created by Nick Schwab on 6/24/22.
//

import SwiftUI

struct SettingsView: View {
    
    @State var defaultReps = ""
    @State var defaultWeight = ""
    @State var defaultRPE = ""
    @State var name = "Megan"
    @State var enableRPE = true
    @State var enableRIR = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    List {
                        Section("Default Set Values") {
                            HStack {
                                Text("Default Reps")
                                TextField("5", text: $defaultReps)
                            }
                            HStack {
                                Text("Default Weight")
                                TextField("45", text: $defaultWeight)
                            }
                            HStack {
                                Text("Default RPE")
                                TextField("8", text: $defaultRPE)
                            }
                        }
                        
                        Section {
                            HStack {
                                Text("Enable RPE")
                                Spacer()
                                Toggle("", isOn: $enableRPE)
                                    .disabled(true)
                            }
                            HStack {
                                Text("Enable RIR")
                                Spacer()
                                Toggle("", isOn: $enableRIR)
                                    .disabled(true)
                            }
                        }

                    }

                }
                .multilineTextAlignment(.trailing)
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
