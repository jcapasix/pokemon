//
//  PokemonCell.swift
//  Presentation
//
//  Created by Jordan Capa on 2/16/25.
//


import UIKit
import DomainLayer
import SDWebImage

class PokemonCell: UITableViewCell {
    
    static let identifier = "PokemonCell"
    
    private let pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let pokemonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(pokemonImage)
        contentView.addSubview(pokemonName)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = Utils.backgroundColor
        selectionStyle = .none
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pokemonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            pokemonImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pokemonImage.widthAnchor.constraint(equalToConstant: 90),
            pokemonImage.heightAnchor.constraint(equalToConstant: 120),
            pokemonName.leadingAnchor.constraint(equalTo: pokemonImage.trailingAnchor, constant: 20),
            pokemonName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pokemonName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            pokemonName.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configure(with model: PokemonModel) {
        pokemonName.text = model.name
        if let url = URL(string: model.url) {
            pokemonImage.sd_setImage(with: url, completed: nil)
        }
    }
}

