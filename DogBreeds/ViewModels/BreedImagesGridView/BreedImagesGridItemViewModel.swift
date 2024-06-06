//
//  BreedImagesGridItemViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-28.
//

import Foundation

extension BreedImagesGridItemView {
    
    @MainActor
    class ViewModel: Identifiable, ObservableObject {
        @Published var isLiked: Bool
        
        private let breedImage: BreedImage
        private let storageClient: StorageClient
        
        var imageUrl: String {
            breedImage.url
        }

        var accessibilityLabel:String {
            
            breedImage.isLiked ?
                String(localized: "Show liked breed image", comment: "Breed image grid view button accessibility label - show liked image") :
                String(localized: "Show breed image", comment: "Breed image grid view button accessibility label - show image")
        }
        
        init(breedImage: BreedImage, storageClient: StorageClient) {
            self.breedImage = breedImage
            self.storageClient = storageClient
            isLiked = breedImage.isLiked
        }
        
        func breedImageViewModel() -> BreedImageView.ViewModel {
            BreedImageView.ViewModel(breedImage: breedImage, storageClient: storageClient)
        }
    }
}
