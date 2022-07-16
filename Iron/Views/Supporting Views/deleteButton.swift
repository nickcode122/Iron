//
//  deleteButton.swift
//  Iron
//
//  Created by Nick Schwab on 7/16/22.
//

import SwiftUI

struct deleteButton: View {
    var action: () -> Void
    
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    var body: some View {
        Button(role: .destructive, action: action) {
            Label("Delete", systemImage: "trash.fill")
        }
    }
}
