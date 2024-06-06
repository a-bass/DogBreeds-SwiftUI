//
//  PreviewViewModels.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-27.
//

import Foundation

#if DEBUG

extension ContentView.ViewModel {
    static var preview: ContentView.ViewModel {
        let networkClient = NetworkClient(downloader: PreviewRandomBreedImageDownloader())
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return ContentView.ViewModel(networkClient: networkClient, storageClient: storageClient)
    }
}

extension FeaturedImageListView.ViewModel {
    static var preview: FeaturedImageListView.ViewModel {
        let networkClient = NetworkClient(downloader: PreviewRandomBreedImageDownloader())
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return FeaturedImageListView.ViewModel(networkClient: networkClient, storageClient: storageClient)
    }
}

extension FeaturedImageListRowView.ViewModel {
    static var preview: FeaturedImageListRowView.ViewModel {
        return FeaturedImageListRowView.ViewModel(imageUrl: BreedImage.preview.url, isLiked: true)
    }
}

extension BreedListView.ViewModel {
    static var preview: BreedListView.ViewModel {
        let networkClient = NetworkClient(downloader: PreviewBreedsDownloader())
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return BreedListView.ViewModel(networkClient: networkClient, storageClient: storageClient)
    }
}

extension BreedListSectionView.ViewModel {
    static var preview: BreedListSectionView.ViewModel {
        let networkClient = NetworkClient(downloader: PreviewBreedsDownloader())
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return BreedListSectionView.ViewModel(indexCharacter: "B", breeds: Breed.previews, networkClient: networkClient, storageClient: storageClient)
    }
}

extension BreedListRowView.ViewModel {
    static var preview: BreedListRowView.ViewModel {
        let networkClient = NetworkClient(downloader: PreviewRandomBreedImageDownloader())
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return BreedListRowView.ViewModel(breed: Breed.preview, networkClient: networkClient, storageClient: storageClient)
    }
}

extension BreedImagesGridView.ViewModel {
    static var preview: BreedImagesGridView.ViewModel {
        let networkClient = NetworkClient(downloader: PreviewBreedImagesDownloader())
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return BreedImagesGridView.ViewModel(breed: Breed.preview, networkClient: networkClient, storageClient: storageClient)
    }
}

extension BreedImagesGridItemView.ViewModel {
    static var preview: BreedImagesGridItemView.ViewModel {
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return BreedImagesGridItemView.ViewModel(breedImage: BreedImage.preview, storageClient: storageClient)
    }
}

extension LikedImageListView.ViewModel {
    static var preview: LikedImageListView.ViewModel {
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return LikedImageListView.ViewModel(storageClient: storageClient)
    }
}

extension LikedImageListRowView.ViewModel {
    static var preview: LikedImageListRowView.ViewModel {
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return LikedImageListRowView.ViewModel(breedImage: BreedImage.preview, storageClient: storageClient)
    }
}

extension BreedImageView.ViewModel {
    static var preview: BreedImageView.ViewModel {
        let storageClient = StorageClient(modelContext: previewModelContainer.mainContext)
        return BreedImageView.ViewModel(breedImage: BreedImage.preview, storageClient: storageClient)
    }
}

extension ErrorView.ViewModel {
    static var preview: ErrorView.ViewModel {
        return ErrorView.ViewModel(error: DogBreedsError.networkError)
    }
}

#endif
