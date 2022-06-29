//
//  DismissKeyboardExtension.swift
//  Iron
//
//  Created by Nick Schwab on 6/29/22.
//

import SwiftUI
//This extension allows for easy dismissal of a keyboard/editing selection.
//To use: call UIApplication.shared.endEditing()
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
