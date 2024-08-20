//
//  WalletIconBackgroundPicker.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/19/24.
//

import SwiftUI
import Styleguide

struct WalletIconBackgroundPicker: View {
    private let colors: [Color] = [
        .regular.red,
        .regular.pastelRed,
        .regular.orange,
        .regular.pink,
        .regular.purple,
        .regular.blue,
        .regular.lightBlue,
        .regular.blueGreen,
        .regular.darkGreen,
        .regular.darkGray,
        .regular.lightGray
    ]

    @Binding var selected: Color

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer().frame(width: Dimensions.shared.eight)

                ForEach(colors, id: \.self) { color in
                    ItemView(color: color, selected: $selected)
                }

                Spacer().frame(width: Dimensions.shared.eight)
            }
        }
    }
}

private struct ItemView: View {
    let color: Color
    @Binding var selected: Color
    @State private var isTapped = false
    @State private var feedbackTrigger = 0

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: 42)
            .onTapGesture {
                feedbackTrigger += 1
                selected = color
            }
            .sensoryFeedback(.impact(weight: .light), trigger: feedbackTrigger)
    }
}

#Preview {
    WalletIconBackgroundPicker(selected: .constant(.regular.purple))
}
