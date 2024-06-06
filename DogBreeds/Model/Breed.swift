//
//  Breed.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-05.
//

import Foundation

struct Breed: Codable {
    let name: String
    let type: String
    
    var isSubBreed: Bool {
        return !type.isEmpty
    }
    
    var displayName: String {
        !isSubBreed ? name.capitalized : "\(name.capitalized) - \(type.capitalized)"
    }
    
    init(name: String, type: String = "") {
        self.name = name
        self.type = type
    }
}

extension Breed: Comparable {
    static func < (lhs: Breed, rhs: Breed) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Breed, rhs: Breed) -> Bool {
        lhs.name == rhs.name
    }
}
