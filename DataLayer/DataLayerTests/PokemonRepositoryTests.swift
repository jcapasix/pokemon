//
//  PokemonRepositoryTests.swift
//  DataLayerTests
//
//  Created by Jordan Capa on 2/17/25.
//

import XCTest
import CoreData
import Alamofire
import OHHTTPStubs
import OHHTTPStubsSwift
@testable import DataLayer

class PokemonRepositoryTests: XCTestCase {
    
    var pokemonRepository: PokemonRepository!
    var mockContext: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        mockContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        pokemonRepository = PokemonRepository()
    }

    override func tearDown() {
        pokemonRepository = nil
        mockContext = nil
        super.tearDown()
    }
    
    
    func testFetchPokemons_API() async throws {
        let url = "\(pokemonRepository.baseURL)\(pokemonRepository.version)/ability/?offset=0&limit=10"
        let pokemonResponse = PokemonResponseDataModel(count: 2, results: [
            PokemonDataModel(name: "Pikachu", url: "https://pokeapi.co/api/v2/pokemon/1/"),
            PokemonDataModel(name: "Bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/2/")
        ])
        mockAlamofireRequest(url: url, response: pokemonResponse)
        let pokemons = try await pokemonRepository.fetchPokemons(limit: 10)
        XCTAssertEqual(pokemons.count, 10, "Debe devolver dos pokemons")
        XCTAssertEqual(pokemons.first?.name, "stench", "El primer pokemon debe ser Pikachu")
    }
    
    private func mockAlamofireRequest(url: String, response: PokemonResponseDataModel? = nil, error: Error? = nil) {
        if let response = response {
            stub(condition: isPath(url)) { _ in
                let data = try! JSONEncoder().encode(response)
                return HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
            }
        } else if let error = error {
            stub(condition: isPath(url)) { _ in
                return HTTPStubsResponse(error: error)
            }
        }
    }
}

