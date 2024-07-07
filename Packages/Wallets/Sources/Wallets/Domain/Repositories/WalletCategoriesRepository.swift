//
//  WalletCategoriesRepository.swift
//  
//
//  Created by Dimas Gabriel on 7/5/24.
//

protocol WalletCategoriesRepositoryProtocol {
    func getAll() async throws -> [WalletCategory]
    func create(category: WalletCategory) async throws
}
