//
//  PokemonFactory.swift
//  Presentation
//
//  Created by Jordan Capa on 2/16/25.
//
import UIKit
import DomainLayer
import DataLayer

enum PokemonFactoryType {
    case pokemonList
    case pokemonDetail(pokemon: PokemonModel)
}

class PokemonFactory {
    static func makeViewController(type: PokemonFactoryType) -> UIViewController {
        switch type {
        case .pokemonList:
            return pokemonListViewController()
        case .pokemonDetail(let pokemon):
            return pokemonDetailViewController(pokemon: pokemon)
        }
    }
    
    static func pokemonListViewController() -> PokemonListViewController {
        let viewController = PokemonListViewController()
        let getPokemonListUseCase = GetPokemonListUseCase(
            repository: PokemonRepository()
        )
        viewController.viewModel = PokemonListViewModel(
            getPokemonListUseCase: getPokemonListUseCase
        )
        return viewController
    }
    
    static func pokemonDetailViewController(pokemon: PokemonModel) -> PokemonDetailViewController {
        let viewController = PokemonDetailViewController()
        viewController.viewModel = PokemonDetailViewModel(pokemon: pokemon)
        return viewController
    }
}
