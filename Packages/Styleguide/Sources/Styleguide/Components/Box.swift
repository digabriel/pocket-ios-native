//
//  Box.swift
//  Styleguide
//
//  Created by Dimas Gabriel on 8/21/24.
//

import SwiftUI

public struct Box<Content: View>: View {
    @ViewBuilder let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        content
            .padding(.all, Dimensions.shared.fourteen)
            .background(Color.regular.white)
            .cornerRadius(16)
            .shadow(color: Color.regular.black.opacity(0.25), radius: 10, y: 4)
    }
}

#Preview {
    Box {
        Text("Dimas")
    }
}
