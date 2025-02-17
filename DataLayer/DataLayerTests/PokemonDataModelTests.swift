//
//  PokemonDataModelTests.swift
//  DataLayerTests
//
//  Created by Jordan Capa on 2/17/25.
//

import XCTest
@testable import DataLayer

class PokemonDataModelTests: XCTestCase {

    static let url = "https://pokeapi.co/api/v2/pokemon/1/"
    
    func testInitialization() {
        let name = "Pikachu"
        let pokemon = PokemonDataModel(name: name, url: PokemonDataModelTests.url)
        XCTAssertEqual(pokemon.name, name, "El nombre debe coincidir")
        XCTAssertEqual(pokemon.url, PokemonDataModelTests.url, "La URL debe coincidir")
    }
    
    func testCodable() {
        let pokemon = PokemonDataModel(name: "Pikachu", url: PokemonDataModelTests.url)
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(pokemon)
            let decoder = JSONDecoder()
            let decodedPokemon = try decoder.decode(PokemonDataModel.self, from: data)
            XCTAssertEqual(decodedPokemon.name, pokemon.name, "El nombre decodificado debe coincidir")
            XCTAssertEqual(decodedPokemon.url, pokemon.url, "La URL decodificada debe coincidir")
        } catch {
            XCTFail("Error al codificar o decodificar el modelo: \(error)")
        }
    }
}
