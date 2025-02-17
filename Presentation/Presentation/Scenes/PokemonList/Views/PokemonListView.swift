//
//  PokemonListView.swift
//  Presentation
//
//  Created by Jordan Capa on 2/16/25.
//


import UIKit
import DomainLayer

protocol PokemonListViewDelegate {
    func didSelectPokemon(pokemon: PokemonModel)
}

class PokemonListView: UIView {
    
    // MARK: - UI Elements
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Buscar Pokémon"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = Utils.backgroundColor
        searchBar.backgroundColor = Utils.backgroundColor
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .white
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Buscar Película", attributes: attributes)
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private var pokemons: [PokemonModel] = [] {
        didSet {
            Task {
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    public var delegate: PokemonListViewDelegate?
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = self.bounds
        tableView.backgroundView = activityIndicator
        tableView.backgroundColor = Utils.backgroundColor
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        self.activityIndicator.startAnimating()
        backgroundColor = Utils.backgroundColor
        addSubview(searchBar)
        addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func updatePokemons(pokemons: [PokemonModel]) {
        self.pokemons = pokemons
    }
}

extension PokemonListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemon = pokemons[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else {
            return UITableViewCell()
        }
        cell.configure(with: pokemon)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = pokemons[indexPath.row]
        delegate?.didSelectPokemon(pokemon: pokemon)
    }
}
