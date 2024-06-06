//
//  PreviewObjects.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-27.
//

import Foundation
import SwiftData

#if DEBUG

extension Breed {
    static var preview: Breed {
        Breed(name: "bulldog",
              type: "boston")
    }
    
    static var previews: [Breed] {
        [Breed.preview, Breed.preview]
    }
}

extension BreedImage {
    static var preview: BreedImage {
        BreedImage(url: "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg", 
                   breed: Breed(name: "bulldog",
                                type: "boston"))
    }
}

@MainActor let previewModelContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: BreedImage.self, configurations: config)
        
        container.mainContext.insert(BreedImage.preview)
            return container
    } catch {
        fatalError("Failed to create container")
    }
}()

#endif
