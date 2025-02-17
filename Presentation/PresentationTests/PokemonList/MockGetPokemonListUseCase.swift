//
//  MockGetPokemonListUseCase.swift
//  PresentationTests
//
//  Created by Jordan Capa on 2/17/25.
//

import XCTest
import Combine
@testable import Presentation
@testable import DomainLayer
@testable import DataLayer

class MockGetPokemonListUseCase: GetPokemonListUseCaseProtocol {
    var shouldThrowError = false
    var mockPokemons: [PokemonDataModel] = []
    
    func execute(limit: Int) async throws -> [DataLayer.PokemonDataModel] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return mockPokemons
    }
}
