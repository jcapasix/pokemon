//
//  PokemonDetailView.swift
//  Presentation
//
//  Created by Jordan Capa on 2/17/25.
//
import UIKit
import DomainLayer

class PokemonDetailView: UIView {
    
    // MARK: - UI Elements

    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = Utils.backgroundColor
        addSubview(posterImageView)
        addSubview(titleLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            posterImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 120),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }

    func updatePokemonDetails(pokemon: PokemonModel) {
        if let posterPath = URL(string: pokemon.url) {
            posterImageView.sd_setImage(with: posterPath, completed: nil)
        }
        titleLabel.text = pokemon.name
    }
}
