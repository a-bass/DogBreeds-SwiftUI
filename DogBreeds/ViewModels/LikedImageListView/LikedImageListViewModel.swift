//
//  LikedImageListViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-28.
//

import Foundation

extension LikedImageListView {
    
    @MainActor
    class ViewModel: LoadableViewModel {
        @Published private(set) var state = LoadingState<[LikedImageListRowView.ViewModel]>.loading
        @Published var selectedFilter = FilterOption.none {
            didSet {
                applyFilterAndSort()
            }
        }
        @Published var filters = [FilterOption.none]
        @Published var sortAscending = true {
            didSet {
                applyFilterAndSort()
            }
        }
        @Published var contentUnavailable = false
        
        private let storageClient: StorageClient
        private var likedImages = [BreedImage]()
        private var filteredLikedImages = [BreedImage]()
        private var rowViewModels = [LikedImageListRowView.ViewModel]()
        
        var title: String {
            String(localized: "Liked images", comment: "Liked image view - title")
        }
        
        var removeAlertTitle: String {
            String(localized: "Warning", comment: "Liked image view alert - title")
        }
        var removeAlertMessage: String {
            String(localized: "Are you sure you want to remove all liked images?", comment: "Liked image view alert - message")
        }
        var removeAlertDeleteButtonText: String {
            String(localized: "Delete", comment: "Liked image view alert - button")
        }
        
        var contentUnavailableTitle: String {
            String(localized: "No likes", comment: "Liked image view unavailable - title")
        }
        var contentUnavailableMessage: String {
            String(localized: "You have not liked any images", comment: "Liked image view unavailable - message")
        }
        
        var sortButtonAccessibilityLabel: String {
            String(localized: "Sort", comment: "Liked image view button accessibility label - sort")
        }
        var filterMenuAccessibilityLabel: String {
            String(localized: "Filter menu", comment: "Liked image view menu accessibility label - filter")
        }
        var filterOptionsAccessibilityLabel: String {
            String(localized: "Filter options", comment: "Liked image view menu accessibility label - options")
        }
        var removeButtonAccessibilityLabel: String {
            String(localized: "Remove all", comment: "Liked image view button accessibility label - remove")
        }
        
        init(storageClient: StorageClient) {
            self.storageClient = storageClient
        }
        
        func load() async {
            do {
                likedImages = try storageClient.LikedImages()

                loadFilters()
                applyFilterAndSort()
            } catch {
                state = .failed(error)
            }
        }
        
        private func loadFilters() {
            let breedNames = likedImages.map { $0.breed.name }
            
            filters = FilterOption.options(from: breedNames)
            
            if !filters.contains(where: { $0 == selectedFilter }) {
                selectedFilter = FilterOption.none
            }
        }
        
        private func applyFilterAndSort() {
            if selectedFilter != FilterOption.none {
                filteredLikedImages = likedImages.filter { $0.breed.name == selectedFilter.title }
            } else {
                filteredLikedImages = likedImages
            }
            
            if sortAscending {
                filteredLikedImages.sort(by: <)
            } else {
                filteredLikedImages.sort(by: >)
            }
            
            rowViewModels = filteredLikedImages.map({ likedImage in
                LikedImageListRowView.ViewModel(breedImage: likedImage, 
                                                storageClient: storageClient)
            })
            
            state = .loaded(rowViewModels)
            contentUnavailable = rowViewModels.isEmpty
        }
        
        func remove(atOffsets indexSet: IndexSet) {
            do {
                try indexSet.forEach { (i) in
                    let imageUrl = filteredLikedImages[i].url
                    try storageClient.removeLikedImage(with: imageUrl)
                }
                Task {
                    await load()
                }
            } catch {
            }
        }
        
        func removeAll() {
            do {
                try storageClient.removeAllLikedImages()
                Task {
                    await load()
                }
            } catch {
                state = .failed(error)
            }
        }
    }
}
