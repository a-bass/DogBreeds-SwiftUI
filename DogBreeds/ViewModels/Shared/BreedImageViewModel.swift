//
//  BreedImageViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-28.
//

import Foundation

extension BreedImageView {
    
    @MainActor
    class ViewModel: LoadableViewModel {
        @Published private(set) var state = LoadingState<String>.loading
        @Published var showRemoveAlert = false
        @Published var isLiked: Bool = false {
            didSet {
                if case .loaded(_) = state {
                    toggleLiked()
                }
            }
        }
        
        private var breedImage: BreedImage
        private let storageClient: StorageClient
        
        var title: String {
            breedImage.breed.displayName
        }
        var imageName: String {
            breedImage.imageName
        }
        
        var removeAlertTitle: String {
            String(localized: "Warning", comment: "Breed image view alert - title")
        }
        var removeAlertMessage: String {
            String(localized: "Are you sure you want to remove the image from liked images?", comment: "Breed image view alert - message")
        }
        var removeAlertDeleteButtonText: String {
            String(localized: "Delete", comment: "Breed image view alert - button")
        }
        
        var likedButtonAccessibilityLabel: String {
            breedImage.isLiked ?
                String(localized: "Remove like", comment: "Breed image view liked button - remove") :
                String(localized: "Add like", comment: "Breed image view liked button - add")
        }
        var fileNameTextAccessibilityLabel: String {
            String(localized: "Image filenamne", comment: "Breed image view accessibility label - filenamne")
        }
        
        init(breedImage: BreedImage, storageClient: StorageClient) {
            self.breedImage = breedImage
            self.storageClient = storageClient
        }
        
        func load() async {
            switch state {
            case .loaded(_), .failed(_):
                state = .loading
                do {
                    breedImage = BreedImage(url: breedImage.url, breed: breedImage.breed)
                    
                    if let breedImage = try storageClient.likedImage(for: breedImage.url) {
                        self.breedImage.likedDate = breedImage.likedDate
                    } else {
                        breedImage.likedDate = nil
                    }
                } catch {
                    state = .failed(error)
                    return
                }
            case .loading:
                break
            }
            
            isLiked = breedImage.isLiked
            state = .loaded(breedImage.url)
        }
        
        func removeLike() {
            do {
                try storageClient.removeLikedImage(with: breedImage.url)
                
                Task {
                    await load()
                }
            } catch {
                state = .failed(error)
            }
        }
        
        func cancelRemoveLike() {
            Task {
                await load()
            }
        }
        
        private func toggleLiked() {
            do {
                if isLiked {
                    state = .loading
                    try storageClient.addLikedImage(from: breedImage)
                    
                    Task {
                        await load()
                    }
                } else  {
                    showRemoveAlert = true
                }
            } catch {
                state = .failed(error)
            }
        }
    }
}
