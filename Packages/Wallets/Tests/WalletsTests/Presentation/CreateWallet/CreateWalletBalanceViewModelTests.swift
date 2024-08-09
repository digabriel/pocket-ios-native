//
//  CreateWalletBalanceViewModelTests.swift
//  Wallets
//
//  Created by Dimas Gabriel on 8/9/24.
//

import Testing
@testable import Wallets

@MainActor
struct CreateWalletBalanceViewModelTests {
    private func makeSut(model: CreateWalletModel = .mock()) -> CreateWalletBalanceView.ViewModel {
        return .init(model: model)
    }

    @Test func titleShouldMatchModelName() {
        let expectedTitle = "My Beautiful Title"
        let model = CreateWalletModel.mock(name: expectedTitle)

        let sut = makeSut(model: model)

        #expect(sut.title == expectedTitle)
    }
}
