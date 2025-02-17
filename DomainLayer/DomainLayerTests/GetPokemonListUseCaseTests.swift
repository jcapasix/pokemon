//
//  GetPokemonListUseCaseTests.swift
//  DomainLayerTests
//
//  Created by Jordan Capa on 2/17/25.
//

import XCTest
@testable import DomainLayer
@testable import DataLayer

class GetPokemonListUseCaseTests: XCTestCase {

    var useCase: GetPokemonListUseCase!
    var mockRepository: MockPokemonRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockPokemonRepository()
        useCase = GetPokemonListUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        useCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testExecute_ReturnsCorrectPokemonList() async throws {
        let limit = 3
        let result = try await useCase.execute(limit: limit)
        
        XCTAssertEqual(result.count, limit, "El número de Pokémon devueltos no es correcto.")
        for (index, pokemon) in result.enumerated() {
            XCTAssertEqual(pokemon.name, "Pokemon\(index + 1)", "El nombre del Pokémon no coincide.")
            XCTAssertEqual(pokemon.url, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(index).png", "La URL de la imagen del Pokémon no coincide.")
        }
    }
    
    func testExecute_WhenRepositoryThrowsError_ThrowsError() async {
        mockRepository.shouldThrowError = true
        do {
            _ = try await useCase.execute(limit: 3)
            XCTFail("Se esperaba que la función lanzara un error, pero no lo hizo.")
        } catch {
            XCTAssertNotNil(error, "Se esperaba un error, pero fue nil.")
        }
    }
}

