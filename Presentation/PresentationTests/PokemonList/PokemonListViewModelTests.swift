//
//  PokemonListViewModelTests.swift
//  Presentation
//
//  Created by Jordan Capa on 2/17/25.
//

import XCTest
import Combine
@testable import Presentation
@testable import DomainLayer
@testable import DataLayer

class PokemonListViewModelTests: XCTestCase {
    private var viewModel: PokemonListViewModel!
    private var mockUseCase: MockGetPokemonListUseCase!
    private var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockGetPokemonListUseCase()
        viewModel = PokemonListViewModel(getPokemonListUseCase: mockUseCase)
    }
    
    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchPokemonsSuccess() async {
        mockUseCase.mockPokemons = [
            PokemonDataModel(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonDataModel(name: "Charmander", url: "https://pokeapi.co/api/v2/pokemon/4/")
        ]
        let expectation = XCTestExpectation(description: "Wait for pokemons to be updated")
        viewModel.$pokemons
            .dropFirst()
            .sink { pokemons in
                if !pokemons.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.fetchPokemons()
        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertEqual(viewModel.pokemons.count, 2)
        XCTAssertEqual(viewModel.pokemons.first?.name, "Bulbasaur")
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchPokemonsFailure() async {
        mockUseCase.shouldThrowError = true
        let expectation = XCTestExpectation(description: "Wait for errorMessage to be updated")
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                if errorMessage != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        viewModel.fetchPokemons()
        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.pokemons.isEmpty)
    }
    
    func testSearchPokemon() async {
        mockUseCase.mockPokemons = [
            PokemonDataModel(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonDataModel(name: "Charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
            PokemonDataModel(name: "Squirtle", url: "https://pokeapi.co/api/v2/pokemon/7/")
        ]
        let expectation = XCTestExpectation(description: "Wait for pokemons to be updated")
        viewModel.$pokemons
            .dropFirst()
            .sink { pokemons in
                if pokemons.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        viewModel.fetchPokemons()
        await fulfillment(of: [expectation], timeout: 2.0)
        viewModel.searchPokemon(query: "char")
        XCTAssertEqual(viewModel.pokemons.count, 1)
        XCTAssertEqual(viewModel.pokemons.first?.name, "Charmander")
        viewModel.searchPokemon(query: "")
        XCTAssertEqual(viewModel.pokemons.count, 3)
    }
}
