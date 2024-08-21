//
//  Toggle.swift
//  Styleguide
//
//  Created by Dimas Gabriel on 8/21/24.
//

import SwiftUI

public struct Toggle: View {
    let title: String
    let description: String?

    @Binding private var isEnabled: Bool

    public init(title: String, description: String? = nil, isEnabled: Binding<Bool>) {
        self.title = title
        self.description = description
        self._isEnabled = isEnabled
    }

    public var body: some View {
        HStack(spacing: Dimensions.shared.five) {
            VStack(alignment: .leading, spacing: Dimensions.shared.three) {
                Text(title)
                    .foregroundStyle(Color.regular.black)
                    .font(Font.title.smallRounded)

                if let description {
                    Text(description)
                        .foregroundStyle(Color.regular.gray)
                        .font(Font.text.small)
                }
            }

            Spacer()

            SwiftUI.Toggle("", isOn: $isEnabled)
                .labelsHidden()
        }
    }
}

#Preview {
    @Previewable @State var isEnabled = false

    Toggle(title: "A Toggle", description: "A toggle description", isEnabled: $isEnabled)
        .padding()

    Toggle(title: "A Toggle without description", isEnabled: $isEnabled)
        .padding()
        .tint(Color.regular.yellow)
}
