//
//  PokemonDetailViewModel.swift
//  Presentation
//
//  Created by Jordan Capa on 2/16/25.
//

import UIKit
import Combine

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: PokemonModel
    
    init(pokemon: PokemonModel) {
        self.pokemon = pokemon
    }
}
