//
//  BreedImage.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-26.
//

import Foundation
import SwiftData

@Model
class BreedImage: Identifiable {
    @Attribute(.unique) let url: String
    let breed: Breed
    var likedDate: Date?

    var imageName: String {
        guard let lastIndex = url.lastIndex(of: "/"),
              lastIndex < url.endIndex else {
            return ""
        }
        let startIndex = url.index(lastIndex, offsetBy: 1)
        return String(url.suffix(from: startIndex))
    }
    
    var isLiked: Bool {
        return likedDate != nil
    }
    
    init(url: String, breed: Breed, likedDate: Date? = nil) {
        self.url = url
        self.breed = breed
        self.likedDate = likedDate
    }
}

extension BreedImage: Comparable {
    static func < (lhs: BreedImage, rhs: BreedImage) -> Bool {
        lhs.breed.name < rhs.breed.name
    }
    
    static func == (lhs: BreedImage, rhs: BreedImage) -> Bool {
        lhs.breed.name == rhs.breed.name
    }
}
