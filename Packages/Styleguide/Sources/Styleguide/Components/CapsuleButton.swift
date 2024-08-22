//
//  CapsuleButton.swift
//  
//
//  Created by Dimas Gabriel on 6/20/24.
//

import SwiftUI

public struct CapsuleButton: View {
    let title: String
    let action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button {
            action()
        } label: {
            Capsule()
                .fill(Color.regular.black)
                .frame(maxHeight: CapsuleButton.defaultHeight)
                .overlay {
                    Text(title)
                        .foregroundColor(Color.regular.white)
                        .font(Font.button.regular)
                }
        }
    }
}

public extension CapsuleButton {
    static var defaultHeight: CGFloat = 66
}

#Preview {
    CapsuleButton(title: "Continue") {}
}
