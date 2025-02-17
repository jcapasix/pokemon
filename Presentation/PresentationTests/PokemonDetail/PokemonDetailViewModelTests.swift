//
//  PokemonDetailViewModelTests.swift
//  PresentationTests
//
//  Created by Jordan Capa on 2/17/25.
//

import XCTest
import Combine
@testable import Presentation
@testable import DomainLayer
@testable import DataLayer

class PokemonDetailViewModelTests: XCTestCase {
    var viewModel: PokemonDetailViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        let samplePokemon = PokemonModel(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        viewModel = PokemonDetailViewModel(pokemon: samplePokemon)
    }

    override func tearDown() {
        viewModel = nil
        cancellables.removeAll()
        super.tearDown()
    }

    func testInitialization() {
        XCTAssertEqual(viewModel.pokemon.name, "Bulbasaur")
    }

    func testPublishedPokemonUpdates() {
        let expectation = expectation(description: "Pokemon updates trigger publisher")
        var receivedUpdates = [PokemonModel]()
        viewModel.$pokemon
            .sink { receivedPokemon in
                receivedUpdates.append(receivedPokemon)
                if receivedUpdates.count == 2 { expectation.fulfill() }
            }
            .store(in: &cancellables)
        let newPokemon = PokemonModel(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
        viewModel.pokemon = newPokemon
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedUpdates.last?.name, "Bulbasaur")
    }
}
