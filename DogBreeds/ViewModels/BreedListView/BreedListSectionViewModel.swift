//
//  BreedListSectionViewModel.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-06-02.
//

import Foundation

extension BreedListSectionView {
    
    @MainActor
    class ViewModel: Identifiable, ObservableObject {
        private let breeds: [Breed]
        private let networkClient: NetworkClient
        private let storageClient: StorageClient

        let id = UUID()
        let indexCharacter: String
        var rowViewModels: [BreedListRowView.ViewModel] {
            breeds.map { breed in
                BreedListRowView.ViewModel(breed: breed,
                                           networkClient: networkClient, 
                                           storageClient: storageClient)
            }
        }

        init(indexCharacter: String, breeds: [Breed], networkClient: NetworkClient, storageClient: StorageClient) {
            self.indexCharacter = indexCharacter
            self.breeds = breeds
            self.networkClient = networkClient
            self.storageClient = storageClient
        }
    }
}
