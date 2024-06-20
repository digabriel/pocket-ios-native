//
//  Colors.swift
//
//
//  Created by Dimas Gabriel on 6/19/24.
//

import SwiftUI
import Foundation

public extension Color {
    static let background = Background()
    static let regular = Regular()

    struct Background {
        public let pastel = Color(.backgroundPastel)
        public let lightGray = Color(.backgroundLightGray)
    }

    struct Regular {
        public let orange = Color(.orange)
        public let black = Color(.black)
        public let white = Color(.white)
        public let gray = Color(.gray)
    }
}
