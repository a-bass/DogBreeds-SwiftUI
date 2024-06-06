//
//  BreedListRowViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-06-01.
//

import Foundation

extension BreedListRowView {
    
    @MainActor
    class ViewModel: Identifiable, ObservableObject {
        @Published var hasLikedImages = false
        @Published var imageUrl = ""
        
        private let breed: Breed
        private let networkClient: NetworkClient
        private let storageClient: StorageClient
        
        var title: String {
            breed.displayName
        }
        var isSubItem: Bool {
            breed.isSubBreed
        }
        
        var accessibilityLabel:String {
            String(localized: "Show breeds", comment: "Breed list view button accessibility label - show breeds")
        }
        
        init(breed: Breed, networkClient: NetworkClient, storageClient: StorageClient) {
            self.breed = breed
            self.networkClient = networkClient
            self.storageClient = storageClient
            
            load()
        }
        
        private func load() {
            update()
                
            Task {
                guard let apiUrl = URL(string: breed.randomImageApiUrl),
                        let imageUrl = try? await networkClient.breedImageUrl(from: apiUrl) else {
                    self.imageUrl = "invalid"
                    return
                }
                self.imageUrl = imageUrl
            }
        }
        
        func update() {
            hasLikedImages = storageClient.hasLikedImages(breed: breed)
        }
        
        func gridViewModel() -> BreedImagesGridView.ViewModel {
            return BreedImagesGridView.ViewModel(breed: breed, networkClient: networkClient, storageClient: storageClient)
        }
    }
}
