//
//  CreateWalletModel.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import Foundation
import CommonDomain
import SwiftUI

struct CreateWalletModel: Equatable, Hashable {
    let name: String
    let category: WalletCategory
    let initialBalance: Money
    let iconName: String
    let iconBackgroundColor: Color
}
