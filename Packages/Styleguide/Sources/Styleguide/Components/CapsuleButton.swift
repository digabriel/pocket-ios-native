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
                .frame(maxHeight: 66)
                .overlay {
                    Text(title)
                        .foregroundColor(Color.regular.white)
                        .font(Font.button.regular)
                }
        }
    }
}

#Preview {
    CapsuleButton(title: "Continue") {}
}
