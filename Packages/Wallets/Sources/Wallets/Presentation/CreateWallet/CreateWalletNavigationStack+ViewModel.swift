//
//  CreateWalletNavigationStack+ViewModel.swift
//  
//
//  Created by Dimas Gabriel on 7/8/24.
//

import Foundation

extension CreateWalletNavigationStack {
    @Observable final class ViewModel {
        private let dependency: Dependency

        private(set) var sections: [Section] = []
        var currentSectionIndex = 0

        init(dependency: Dependency) {
            self.dependency = dependency
        }

        func refresh() async {
            do {
                let walletCategories = try await dependency.getWalletCategoriesUseCase.execute(input: ())
                sections = walletCategories.map { .init(title: $0.name) }
            } catch {
                sections = []
            }
        }
    }
}

extension CreateWalletNavigationStack {
    struct Section {
        let title: String
    }

    struct Dependency {
        let getWalletCategoriesUseCase: any GetWalletCategoriesProtocol
    }
}
