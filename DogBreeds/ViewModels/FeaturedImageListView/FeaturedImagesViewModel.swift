//
//  FeaturedImagesViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-26.
//

import SwiftUI

extension FeaturedImageListView {
    
    @MainActor
    class ViewModel: LoadableViewModel {
        @Published private(set) var state = LoadingState<[FeaturedImageListRowView.ViewModel]>.loading
        
        private let networkClient: NetworkClient
        private let storageClient: StorageClient
        
        var title: String {
            String(localized: "Featured Images", comment: "Featured image view - Title")
        }
        
        var refreshButtonAccessibilityLabel: String {
            String(localized: "Refresh", comment: "Featured image view button - refresh")
        }
        
        init(networkClient: NetworkClient, storageClient: StorageClient) {
            self.networkClient = networkClient
            self.storageClient = storageClient
        }

        func load() async {
            state = .loading
            
            do {
                let imageUrls = try await networkClient.featuredBreedImageUrls()
                
                if imageUrls.isEmpty {
                    throw DogBreedsError.networkError
                }
                
                let rowViewModels = imageUrls.map({ imageUrl in
                    let isLiked = storageClient.imageLiked(for: imageUrl)
                    
                    return FeaturedImageListRowView.ViewModel(imageUrl: imageUrl, isLiked: isLiked)
                })

                state = .loaded(rowViewModels)
            } catch {
                state = .failed(error)
            }
        }
    }
}
