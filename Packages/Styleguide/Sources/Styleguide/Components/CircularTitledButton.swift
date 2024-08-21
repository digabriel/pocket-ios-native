//
//  CircularTitledButton.swift
//  
//
//  Created by Dimas Gabriel on 7/7/24.
//

import SwiftUI

public struct CircularTitledButton<Icon: View>: View {
    let action: () -> Void
    let icon: () -> Icon
    let title: String

    public init(action: @escaping () -> Void, @ViewBuilder icon: @escaping () -> Icon, title: String) {
        self.action = action
        self.icon = icon
        self.title = title
    }

    public var body: some View {
        Button { action() } label: {
            VStack(spacing: Dimensions.shared.six) {
                Circle()
                    .fill(Color.regular.dark)
                    .frame(width: 80, height: 80)
                    .overlay {
                        icon()
                            .foregroundStyle(Color.regular.white)
                            .font(Font.text.larger)
                    }
                    .shadow(color: Color.regular.black.opacity(0.25), radius: 8, y: 4)

                Text(title)
                    .font(Font.title.small)
                    .foregroundStyle(Color.regular.black)
            }

        }
    }
}

#Preview {
    CircularTitledButton(action: {

    }, icon: {
        Image(systemName: "plus")
    }, title: "Title")
}
