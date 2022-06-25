//
//  SettingsView.swift
//  Iron
//
//  Created by Nick Schwab on 6/24/22.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("defaultReps") private var defaultReps = "5"
    @AppStorage("defaultWeight") private var defaultWeight = "45"
    @AppStorage("defaultRPE") private var defaultRPE = "7"
    @AppStorage("defaultRIR") private var defaultRIR = "2"
    @AppStorage("enableRPE") private var enableRPE = true
    @AppStorage("enableRIR") private var enableRIR = false
    @AppStorage("useLastSetValues") private var useLastSetValues = true
    
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
                            HStack {
                                Text("Default RIR")
                                TextField("1", text: $defaultRIR)
                            }
                            HStack {
                                Text("Use Last Set Values")
                                Spacer()
                                Toggle("", isOn: $useLastSetValues)
                            }
                        }
                        
                        Section {
                            HStack {
                                Text("Enable RPE")
                                Spacer()
                                Toggle("", isOn: $enableRPE)
                            }
                            HStack {
                                Text("Enable RIR")
                                Spacer()
                                Toggle("", isOn: $enableRIR)
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
