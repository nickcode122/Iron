//
//  templateAlert.swift
//  Iron
//
//  Created by Nick Schwab on 7/16/22.
//

import SwiftUI

struct templateAlert: View {
    
    @Binding var alertIsPresented: Bool
    @Binding var text: String?
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .textFieldAlert(isPresented: $alertIsPresented) { () -> TextFieldAlert in
                TextFieldAlert(title: "Create Template", message: "Enter a name", text: self.$text)
            }
    }
}
