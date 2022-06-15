//
//  ESetTextfieldView.swift
//  Iron
//
//  Created by Nick Schwab on 6/15/22.
//

import SwiftUI

struct ESetTextfieldView: View {
    @ObservedObject var eSet: ESet
    
    var body: some View {
        
        HStack {
            Text(String(eSet.set))
                .frame(minWidth: 60, alignment:.center)
            TextField("1", text: $eSet.strReps)
                .frame(minWidth: 60)
            TextField("1", text: $eSet.strWeight)
                .frame(minWidth: 60)
            TextField("1", text: $eSet.strRpe)
                .frame(minWidth: 60)
            Toggle(isOn: $eSet.isComplete) {}
                .frame(minWidth: 60)
        }
    }
}

//struct ESetTextfieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        ESetTextfieldView()
//    }
//}
