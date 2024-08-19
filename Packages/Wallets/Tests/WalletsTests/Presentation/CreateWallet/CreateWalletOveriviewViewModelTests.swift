//
//  CreateWalletOveriviewViewModelTests.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/12/24.
//

import Testing
@testable import Wallets

struct CreateWalletOveriviewViewModelTests {
    private func makeSut() -> CreateWalletOverviewView.ViewModel {
        return .init(model: CreateWalletModel.mock())
    }

    @Test func initialTest() {
        let sut = makeSut()
        #expect(true)
    }
}
