//
//  MockPokemonRepository.swift
//  DomainLayerTests
//
//  Created by Jordan Capa on 2/17/25.
//

import XCTest
@testable import DataLayer

class MockPokemonRepository: PokemonRepositoryProtocol {
    var shouldThrowError = false
    
    func fetchPokemons(limit: Int) async throws -> [PokemonDataModel] {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: -1, userInfo: nil)
        }
        return (1...limit).map { index in
            PokemonDataModel(name: "Pokemon\(index)", url: "https://pokeapi.co/pokemon/\(index)")
        }
    }
}
