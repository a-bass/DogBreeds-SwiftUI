//
//  BreedImagesGridViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-23.
//

import Foundation

extension BreedImagesGridView {
    
    @MainActor
    class ViewModel: LoadableViewModel {
        @Published private(set) var state = LoadingState<[BreedImagesGridItemView.ViewModel]>.loading
        
        private let breed: Breed
        private let networkClient: NetworkClient
        private let storageClient: StorageClient
        private var breedImageUrls = [String]()
        private var breedImages = [BreedImage]()
        
        var hasLikedImages = false
        var filterBylikedImages = false {
            didSet {
                applyFilter()
            }
        }
        var title: String {
            breed.displayName
        }
        
        var filterButtonAccessibilityLabel: String {
            String(localized: "Toggle only liked images", comment: "Breed image grid view button accessibility label - toggle liked images")
        }
        
        init(breed: Breed, networkClient: NetworkClient, storageClient: StorageClient) {
            self.breed = breed
            self.networkClient = networkClient
            self.storageClient = storageClient
        }
        
        func load() async {
            state = .loading

            do {
                breedImageUrls = try await networkClient.breedImageUrls(for: breed)

                if breedImageUrls.isEmpty {
                    throw DogBreedsError.networkError
                }
                
                update()
            } catch {
                state = .failed(error)
            }
        }
        
        func update() {
            state = .loading
            
            do {
                let likedImages = try storageClient.likedImages(for: breed)
                
                hasLikedImages = !likedImages.isEmpty
                breedImages = breedImageUrls.map({ url in
                    var likedDate: Date?
                    if let likedImage = likedImages.first(where: { $0.url == url }) {
                        likedDate = likedImage.likedDate
                    }
                    return BreedImage(url: url,
                               breed: breed,
                               likedDate: likedDate)
                })
                
                applyFilter()
            } catch {
                state = .failed(error)
            }
        }
        
        private func applyFilter() {
            state = .loading
            
            var filteredBreedImages = breedImages
            
            if filterBylikedImages && hasLikedImages {
                filteredBreedImages = breedImages.filter { $0.isLiked }
            }
            
            let itemViewModels = filteredBreedImages.map({ breedImage in
                BreedImagesGridItemView.ViewModel(breedImage: breedImage, storageClient: storageClient)
            })
            state = .loaded(itemViewModels)
        }
    }
}
