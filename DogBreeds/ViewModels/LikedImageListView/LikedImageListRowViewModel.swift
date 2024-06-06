//
//  LikedImageListRowViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-28.
//

import Foundation

extension LikedImageListRowView {
    
    @MainActor
    class ViewModel: Identifiable, ObservableObject {
        @Published var isLiked = true
        
        private let breedImage: BreedImage
        private let storageClient: StorageClient
        
        let id = UUID()
        var title: String {
            breedImage.breed.displayName
        }
        var imageUrl: String {
            breedImage.url
        }
        var date: String {
            if let date = breedImage.likedDate {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                dateFormatter.timeStyle = .short
                return dateFormatter.string(from: date)
            }
            return ""
        }
        
        var accessibilityLabel: String {
            String(localized: "Show liked image: \(breedImage.breed.displayName)", comment: "Liked image view - show liked image")
        }
        
        init(breedImage: BreedImage, storageClient: StorageClient) {
            self.breedImage = breedImage
            self.storageClient = storageClient
        }
        
        func breedImageViewModel() -> BreedImageView.ViewModel {
            BreedImageView.ViewModel(breedImage: breedImage, storageClient: storageClient)
        }
    }
}
