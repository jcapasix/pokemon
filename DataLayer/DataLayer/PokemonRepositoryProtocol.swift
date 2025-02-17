//
//  PokemonRepositoryProtocol.swift
//  DataLayer
//
//  Created by Jordan Capa on 2/16/25.
//

public protocol PokemonRepositoryProtocol {
    func fetchPokemons(limit: Int) async throws -> [PokemonDataModel]
}
