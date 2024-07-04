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
        public let pastel = Color(ColorResource.backgroundPastel)
        public let lightGray = Color(ColorResource.backgroundLightGray)
        public let darkPink = Color(ColorResource.backgroundDarkPink)
        public let lightPink = Color(ColorResource.backgroundLightPink)
    }

    struct Regular {
        public let orange = Color(ColorResource.orange)
        public let black = Color(ColorResource.black)
        public let white = Color(ColorResource.white)
        public let gray = Color(ColorResource.gray)
        public let yellow = Color(ColorResource.yellow)
    }
}
