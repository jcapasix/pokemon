//
//  PokemonDataModel.swift
//  DataLayer
//
//  Created by Jordan Capa on 2/16/25.
//

public struct PokemonDataModel: Codable {
    public let name: String
    public let url: String
    
    public init(name: String, url: String){
        self.name = name
        self.url = url
    }
}
