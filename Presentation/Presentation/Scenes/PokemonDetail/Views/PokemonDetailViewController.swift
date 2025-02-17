//
//  PokemonDetailViewController.swift
//  Presentation
//
//  Created by Jordan Capa on 2/16/25.
//

import UIKit
import Combine

class PokemonDetailViewController: UIViewController {
    private var cancellables = Set<AnyCancellable>()
    public var viewModel: PokemonDetailViewModel?
    private let pokemonListView = PokemonDetailView()
    
    override func loadView() {
        self.view = pokemonListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActions()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel?.$pokemon
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemon in
                self?.pokemonListView.updatePokemonDetails(pokemon: pokemon)
            }
            .store(in: &cancellables)
    }
    
    private func configureActions() {
        title = "Pokemon Detail"
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
        }
    }
}
