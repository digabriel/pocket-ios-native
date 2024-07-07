//
//  CreateWalletViewModelTests.swift
//  
//
//  Created by Dimas Gabriel on 7/7/24.
//

import Testing
@testable import Wallets

struct CreateWalletViewModelTests {
    @Test func shouldOutputWalletCategoriesAsSections() {
        let sut = CreateWalletView.ViewModel()

        #expect(sut.sections.count == WalletCategory.allCases.count)
    }
}
