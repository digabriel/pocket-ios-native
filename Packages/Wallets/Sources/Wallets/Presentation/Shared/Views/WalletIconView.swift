//
//  WalletIconView.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/19/24.
//

import SwiftUI

public struct WalletIconView: View {
    let iconName: String
    let backgroundColor: Color

    public var body: some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(backgroundColor)
            .frame(width: 52, height: 52)
            .overlay {
                Image("icons/\(iconName)", bundle: .module)
            }
            .shadow(color: backgroundColor.opacity(0.5), radius: 2, y: 2)
    }
}
