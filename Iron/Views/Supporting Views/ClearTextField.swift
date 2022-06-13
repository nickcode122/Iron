//
//  clearTextField.swift
//  Iron
//
//  Created by Nick Schwab on 6/2/22.
//

import SwiftUI

struct ClearTextField: View {
    
    let titleText: String
    @Binding var text: String
    @State private var previousText: String?
    
    var body: some View {
        TextField(titleText, text: $text, onEditingChanged: { isEditing in
            if isEditing {
                self.previousText = self.text
                text = ""
            } else if let previousText = self.previousText {
                if self.text == ""  {
                    self.text = previousText
                }

            }
        }, onCommit: { self.previousText = nil })
        .keyboardType(.decimalPad)
    }
}

