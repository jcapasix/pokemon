//
//  GetPokemonListUseCaseProtocol.swift
//  DomainLayer
//
//  Created by Jordan Capa on 2/16/25.
//
import DataLayer

public protocol GetPokemonListUseCaseProtocol {
    func execute(limit: Int) async throws -> [PokemonDataModel]
}
