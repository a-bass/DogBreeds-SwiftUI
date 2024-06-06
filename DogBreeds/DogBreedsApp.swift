//
//  DogBreedsApp.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-05.
//

import SwiftUI
import SwiftData

@main
struct DogBreedsApp: App {
    let container: ModelContainer
    let storageClient: StorageClient
    let networkClient: NetworkClient
    
    var body: some Scene {
        WindowGroup {
            let viewModel = ContentView.ViewModel(networkClient: networkClient, storageClient: storageClient)
            ContentView(viewModel: viewModel)
        }
    }
    
    init() {
        do {
            container = try ModelContainer(for: BreedImage.self)
            storageClient = StorageClient(modelContext: container.mainContext)
            networkClient = NetworkClient()
        } catch {
            fatalError("Failed to create ModelContainer for Dog Breeds.")
        }
    }
}
