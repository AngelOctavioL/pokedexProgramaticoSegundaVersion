//
//  Pokemon.swift
//  PokedexNew
//
//  Created by Diplomado on 21/06/24.
//

import Foundation


// Codable es lo mismo que Decodable, Encodable
// podri ser asi struct Pokemon: Decodable, Encodable
// o asi struct Pokemon: Codable
struct Pokemon: Codable {
    struct Location: Codable {
        let latitude: Double
        let longitude: Double
    }
    
    let id: Int
    let name: String
    let number: String
    let type: [String]
    let imageURL: String
    let location: Location?
    
    // para que sean iguales a los nombres del JSON
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case number = "num"
        case type
        case imageURL = "img"
        case location
    }
}
