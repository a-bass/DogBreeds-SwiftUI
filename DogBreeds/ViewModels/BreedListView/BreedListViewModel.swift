//
//  BreedListViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-23.
//

import SwiftUI

extension BreedListView {

    @MainActor
    class ViewModel: LoadableViewModel {
        @Published private(set) var state = LoadingState<[BreedListSectionView.ViewModel]>.loading
        @Published var filterOptions = [FilterOption.none]
        @Published var selectedFilterOption = FilterOption.none {
            didSet {
                applyFilters()
            }
        }
        @Published var sortAscending = true {
            didSet {
                applyFilters()
            }
        }
        @Published var showSubBreeds = true {
            didSet {
                applyFilters()
            }
        }
        
        private let networkClient: NetworkClient
        private let storageClient: StorageClient
        private var breeds = [Breed]()
        private var indexCharacters = [String]()
        
        var title: String {
            String(localized: "Dog Breeds", comment: "Breed list view - title")
        }
        var showSubBreedsLabel: String {
            String(localized: "Show sub-breeds", comment: "Breed list view menu - show sub-breeds")
        }
        
        var sortButtonAccessibilityLabel: String {
            String(localized: "Sort", comment: "Breed list view button accessibility label - sort")
        }
        var filterMenuAccessibilityLabel: String {
            String(localized: "Filter menu", comment: "Breed list view menu accessibility label - filter")
        }
        var filterOptionsAccessibilityLabel: String {
            String(localized:  "Filter options", comment: "Breed list view menu accessibility label - options")
        }
        
        init(networkClient: NetworkClient, storageClient: StorageClient) {
            self.networkClient = networkClient
            self.storageClient = storageClient
        }

        func load() async {
            state = .loading
            
            do {
                breeds = try await networkClient.breeds()

                if breeds.isEmpty {
                    throw DogBreedsError.networkError
                }
                
                loadFilters()
                applyFilters()
            } catch {
                state = .failed(error)
            }
        }
        
        private func applyFilters() {
            state = .loading
            
            var filteredIndexCharacters = indexCharacters
            var filteredBreeds = breeds
            var sectionViewModels = [BreedListSectionView.ViewModel]()
            
            if !showSubBreeds {
                filteredBreeds = breeds.filter { !$0.isSubBreed }
            }
            
            if selectedFilterOption != FilterOption.none {
                filteredIndexCharacters = [selectedFilterOption.title]
                filteredBreeds = filteredBreeds.filter { $0.name.first?.uppercased() == selectedFilterOption.title }
            }
            
            if sortAscending {
                filteredIndexCharacters.sort(by: <)
                filteredBreeds.sort(by: <)
            } else {
                filteredIndexCharacters.sort(by: >)
                filteredBreeds.sort(by: >)
            }
            
            sectionViewModels = filteredIndexCharacters.map({ indexCharacter in
                let breedsWithIndexCharacter = filteredBreeds.filter { $0.name.first?.uppercased() == indexCharacter }
                
                return BreedListSectionView.ViewModel(indexCharacter: indexCharacter,
                                               breeds: breedsWithIndexCharacter,
                                               networkClient: networkClient,
                                               storageClient: storageClient)
            })

            state = .loaded(sectionViewModels)
        }
        
        private func loadFilters() {
            indexCharacters = Array(Set(breeds.compactMap { $0.name.first?.uppercased() })).sorted()
            filterOptions = FilterOption.options(from: indexCharacters)
        }
    }
}
