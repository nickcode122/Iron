//
//  ESetTextfieldView.swift
//  Iron
//
//  Created by Nick Schwab on 6/15/22.
//

import SwiftUI

struct ESetTextfieldView: View {
    @ObservedObject var eSet: ESet
    
    @AppStorage("enableRPE") private var enableRPE = true
    @AppStorage("enableRIR") private var enableRIR = false
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Text(String(eSet.set))
                    .frame(width: geometry.size.width / CGFloat(titleCount), alignment:.center)
                ClearTextField(titleText: "1", text: $eSet.strReps)
                    .frame(width: geometry.size.width / CGFloat(titleCount))
                ClearTextField(titleText: "1", text: $eSet.strWeight)
                    .frame(width: geometry.size.width / CGFloat(titleCount))
                if enableRPE {
                    ClearTextField(titleText: "1", text: $eSet.strRpe)
                        .frame(width: geometry.size.width / CGFloat(titleCount))
                }
                if enableRIR {
                    ClearTextField(titleText:"1", text: $eSet.strRir)
                        .frame(width: geometry.size.width / CGFloat(titleCount))
                }
                Toggle(isOn: $eSet.isComplete) {}
                    .frame(width: geometry.size.width / CGFloat(titleCount))
            }
        }

    }
    private var titleCount: Int {
        var titleCount = 6
        if !enableRPE {titleCount -= 1}
        if !enableRIR {titleCount -= 1}
        
        return titleCount
    }
}

//struct ESetTextfieldView_Previews: PreviewProvider {
//    static var previews: some View {
//        ESetTextfieldView()
//    }
//}
