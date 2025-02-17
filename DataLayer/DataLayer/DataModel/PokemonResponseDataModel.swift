//
//  PokemonResponseDataModel.swift
//  DataLayer
//
//  Created by Jordan Capa on 2/16/25.
//

public struct PokemonResponseDataModel: Codable {
    let count: Int
    let results: [PokemonDataModel]
}
