//
//  Cat.swift
//  SecuredCat
//
//  Created by Jan Kazubski on 29/04/2025.
//

import Foundation

struct Cat: Decodable, Identifiable {
    let id: String
    let url: String
    let breeds: [Breed]?
}

struct Breed: Decodable, Identifiable {
    let id: String
    let name: String
    let temperament: String?
    let lifeSpan: String?
    let origin: String?
    let wikipediaUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case temperament
        case lifeSpan = "life_span"
        case origin
        case wikipediaUrl = "wikipedia_url"
    }
}
