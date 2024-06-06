//
//  AsyncBreedImage.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-28.
//

import SwiftUI

struct AsyncBreedImage: View {
    let urlString: String
    var accessibilityLabel: String
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: urlString)) { phase in
                switch phase {
                case .failure:
                    Image(systemName: "photo")
                        .font(.largeTitle)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                default:
                    ProgressView()
                }
            }
        }
        .accessibilityElement()
        .accessibilityLabel(accessibilityLabel)
        .accessibilityAddTraits(.isImage)
    }
}

#Preview("Success") {
    AsyncBreedImage(urlString: "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg", accessibilityLabel: "Dog breed")
}

#Preview("Failure") {
    AsyncBreedImage(urlString: "failure", accessibilityLabel: "Dog breed")
}

#Preview("Loading") {
    AsyncBreedImage(urlString: "", accessibilityLabel: "Dog breed")
}
