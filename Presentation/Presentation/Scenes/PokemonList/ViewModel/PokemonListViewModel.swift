//
//  PokemonListViewModel.swift
//  Presentation
//
//  Created by Jordan Capa on 2/16/25.
//

import UIKit
import Combine
import DomainLayer

class PokemonListViewModel: ObservableObject {
    
    private let getPokemonListUseCase: GetPokemonListUseCaseProtocol
    @Published var pokemons: [PokemonModel] = []
    @Published var errorMessage: String?
    var allPokemons: [PokemonModel] = []
    
    init(getPokemonListUseCase: GetPokemonListUseCaseProtocol) {
        self.getPokemonListUseCase = getPokemonListUseCase
    }
    
    func fetchPokemons() {
        Task {
            do {
                let fetchedPokemons = try await getPokemonListUseCase.execute(limit: 150)
                self.pokemons = fetchedPokemons.map({
                    PokemonModel(name: $0.name, url: $0.url)
                })
                self.allPokemons = self.pokemons
            } catch {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func searchPokemon(query: String) {
        if query.isEmpty {
            pokemons = allPokemons
        } else {
            pokemons = allPokemons.filter { $0.name.lowercased().contains(query.lowercased()) }
        }
    }
}

