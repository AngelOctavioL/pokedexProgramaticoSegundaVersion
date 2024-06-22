//
//  PokemonDetailViewModel.swift
//  PokedexNew
//
//  Created by Diplomado on 21/06/24.
//

import UIKit

protocol PokemonDetailViewModelDelegate: AnyObject {
    func updatePokemonImage(to image: UIImage)
}

class PokemonDetailViewModel {
    private let pokemon: Pokemon
    
    var pokemonName: String { pokemon.name }
    
    weak var delegate: PokemonDetailViewModelDelegate?
    
    init(with pokemon: Pokemon) {
        self.pokemon = pokemon
        
        if let pokemonImageURL = URL(string: pokemon.imageURL) {
            loadPokemonImage(from: pokemonImageURL)
        }
        
    }
    
    private func loadPokemonImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url),
               let pokemonImage = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.delegate?.updatePokemonImage(to: pokemonImage)
                }
            }
        }
    }
}
