//
//  editButton.swift
//  Iron
//
//  Created by Nick Schwab on 7/16/22.
//

import SwiftUI

struct PencilEditButton: View {
    var action: () -> Void
    
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    var body: some View {
        Button(action: action) {
            Label("Edit", systemImage: "pencil")
        }
        .tint(.yellow)
    }
}
