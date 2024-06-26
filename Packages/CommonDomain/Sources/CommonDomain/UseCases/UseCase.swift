//
//  UseCase.swift
//  
//
//  Created by Dimas Gabriel on 6/26/24.
//

public protocol UseCase {
    associatedtype Input
    associatedtype Output

    func execute(input: Input) async throws-> Output
}
