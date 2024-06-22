//
//  PokemonListViewModel.swift
//  PokedexNew
//
//  Created by Diplomado on 21/06/24.
//

import Foundation

// cada app funciona en un sandbox individual y no es posible que una app vea
// los archivos a otra app

class PokemonListViewModel {
    private let pokemonDataFileName = "pokemon_list"
    private let pokemonDataFileExtension = "json"
    
    private var pokemonList = [Pokemon]()
    
    let cellIdentifier = "pokemonCellIdentifier"
    let title = "Pokedex"
    var pokemonCount: Int { pokemonList.count }
    
    init() {
        pokemonList = loadPokemonData()
    }
    
    private func loadPokemonData() -> [Pokemon] {
        guard let fileURL = Bundle.main.url(forResource: pokemonDataFileName, withExtension: pokemonDataFileExtension),
              let data = try? Data(contentsOf: fileURL),
              let pokemonList = try? JSONDecoder().decode([Pokemon].self, from: data)
        else {
            // los assertionFailure sirven para documentar el codigo por que se eliminan al compilar
            // y lanzan el mensaje en la consola en tiempo de desarrollo
            assertionFailure("Cannot read pokemon file")
            return []
        }
        
        return pokemonList
    }
    
    func pokemon(at indexPath: IndexPath) -> Pokemon {
        return pokemonList[indexPath.row]
    }
}

// Tipos de restricciones
// fileprivate
// private
// internal
// public

