//
//  PokemonRepository.swift
//  DataLayer
//
//  Created by Jordan Capa on 2/16/25.
//

import CoreData
internal import Alamofire

public class PokemonRepository: PokemonRepositoryProtocol {
    
    private let baseURL = "https://pokeapi.co/api"
    private let version = "/v2"
    private let context: NSManagedObjectContext
    
    public init() {
        self.context = PokemonCoreDataStack.shared.context
    }
    
    public func fetchPokemons(limit: Int) async throws -> [PokemonDataModel] {
        let url = "\(baseURL)\(version)/ability/?offset=0&limit=\(limit)"
        do {
            let response = try await AF.request(url, method: .get)
                .validate()
                .serializingDecodable(PokemonResponseDataModel.self)
                .value
            self.savePokemonToCoreData(pokemons: response.results)
            return response.results
        } catch {
            return try await fetchPokemonFromCoreData()
        }
    }
    
    private func savePokemonToCoreData(pokemons: [PokemonDataModel]) {
        for pokemon in pokemons {
            let pokemonCoreData = PokemonCoreData(context: context)
            pokemonCoreData.name = pokemon.name
            pokemonCoreData.url = pokemon.url
        }
        
        do {
            try context.save()
        } catch {
            print("Error al guardar la Pelicula en CoreData: \(error)")
        }
    }
    
    private func fetchPokemonFromCoreData() async throws -> [PokemonDataModel] {
        let fetchRequest: NSFetchRequest<PokemonCoreData> = PokemonCoreData.fetchRequest()
        let fetchedPokemons = try context.fetch(fetchRequest)
        return fetchedPokemons.map { pokemonCoreData in
            PokemonDataModel(name: pokemonCoreData.name ?? "", url: pokemonCoreData.url ?? "")
        }
    }
}
