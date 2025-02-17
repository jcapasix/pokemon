//
//  GetPokemonListUseCase.swift
//  DomainLayer
//
//  Created by Jordan Capa on 2/16/25.
//

import DataLayer

public class GetPokemonListUseCase: GetPokemonListUseCaseProtocol {
    private let repository: PokemonRepository
    
    public init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    public func execute(limit: Int) async throws -> [PokemonDataModel] {
        return try await repository.fetchPokemons(limit: limit).enumerated().map { (index, pokemon) in
            PokemonDataModel(name: pokemon.name, url: getImageUrl(id: index))
        }
    }
    
    private func getImageUrl(id: Int) -> String {
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
    }
}
