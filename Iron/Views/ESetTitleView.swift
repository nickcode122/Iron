//
//  ESetTitleView.swift
//  Iron
//
//  Created by Nick Schwab on 6/25/22.
//

import SwiftUI

struct ESetTitleView: View {
    private let titles = ["Set","Reps","Weight","RPE","RIR","Done"]
    
    @AppStorage("enableRPE") private var enableRPE = true
    @AppStorage("enableRIR") private var enableRIR = false
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(titles, id: \.self) { title in
                    if !enableRPE && title.contains("RPE") {
                        // do nothing
                    } else if !enableRIR && title.contains("RIR") {
                        // do nothing
                    } else {
                        Text(title)
                            .frame(width: geometry.size.width / CGFloat(titleCount), alignment: .center)
                            .font(Font.headline)
                    }

                }
            }
        }
    }
    private var titleCount: Int {
        var titleCount = titles.count
        if !enableRPE {titleCount -= 1}
        if !enableRIR {titleCount -= 1}
        
        return titleCount
    }
}

struct ESetTitleView_Previews: PreviewProvider {
    static var previews: some View {
        ESetTitleView()
    }
}
