//
//  PokemonListViewController.swift
//  Presentation
//
//  Created by Jordan Capa on 2/16/25.
//

import UIKit
import DomainLayer
import Combine

class PokemonListViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    public var viewModel: PokemonListViewModel?
    private let pokemonListView = PokemonListView()
    
    override func loadView() {
        self.view = pokemonListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
        bindViewModel()
        viewModel?.fetchPokemons()
    }
    
    private func configureActions() {
        pokemonListView.searchBar.delegate = self
        pokemonListView.delegate = self
        title = "Pokemon List"
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        }
    }
    
    private func bindViewModel() {
        viewModel?.$pokemons
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemons in
                self?.pokemonListView.updatePokemons(pokemons: pokemons)
            }
            .store(in: &cancellables)
        
        viewModel?.$errorMessage
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                self?.showError(message: errorMessage)
            }
            .store(in: &cancellables)
    }
    
    func showError(message: String) {
        pokemonListView.activityIndicator.stopAnimating()
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension PokemonListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.searchPokemon(query: searchText)
    }
}

extension PokemonListViewController: PokemonListViewDelegate {
    func didSelectPokemon(pokemon: PokemonModel) {
        let viewController = PokemonFactory.makeViewController(type: .pokemonDetail(pokemon: pokemon))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
