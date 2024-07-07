//
//  GetWalletCategoriesPreview.swift
//  
//
//  Created by Dimas Gabriel on 7/6/24.
//

final class GetWalletCategoriesPreview: GetWalletCategoriesProtocol {
    func execute(input: ()) async throws -> Array<WalletCategory> {
        return WalletCategory.allCases
    }
}
