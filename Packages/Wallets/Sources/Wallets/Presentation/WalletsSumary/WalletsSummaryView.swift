//
//  WalletsSummaryView.swift
//  
//
//  Created by Dimas Gabriel on 7/4/24.
//

import SwiftUI
import Styleguide

struct WalletsSummaryView: View {
    var body: some View {
        VStack(spacing: Dimensions.shared.two) {
            Text("$0")
                .font(Font.title.largerRounded)

            Text("TOTAL NET WORTH")
                .font(Font.text.smaller)
                .kerning(1)
        }
        .foregroundStyle(Color.regular.white)
    }
}

#Preview {
    WalletsSummaryView()
        .padding()
        .background(Color.red)
}
