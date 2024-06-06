//
//  ContentViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-25.
//

import Foundation

extension ContentView {
    
    @MainActor
    class ViewModel: ObservableObject {
        private let networkClient: NetworkClient
        private let storageClient: StorageClient
        
        enum Tab: String {
            case featured
            case list
            case liked
            
            var title: String {
                switch self {
                case .featured:
                    return String(localized: "Featured", comment: "Content view tab - Featured images")
                case .list:
                    return String(localized: "Breeds", comment: "Content view tab - Breeds list")
                case .liked:
                    return String(localized: "Liked", comment: "Content view tab - Liked images")
                }
            }
            
            var image: String {
                switch self {
                case .featured:
                    return "star"
                case .list:
                    return "list.bullet"
                case .liked:
                    return "heart.fill"
                }
            }
        }
        
        init(networkClient: NetworkClient, storageClient: StorageClient) {
            self.networkClient = networkClient
            self.storageClient = storageClient
        }
        
        @MainActor func featuredViewModel() -> FeaturedImageListView.ViewModel {
            return FeaturedImageListView.ViewModel(networkClient: networkClient, storageClient: storageClient)
        }
        
        @MainActor func breedsViewModel() -> BreedListView.ViewModel {
            return BreedListView.ViewModel(networkClient: networkClient, storageClient: storageClient)
        }
        
        @MainActor func likedImagesViewModel() -> LikedImageListView.ViewModel {
            return LikedImageListView.ViewModel(storageClient: storageClient)
        }
    }
}
