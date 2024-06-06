//
//  StorageClient.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-17.
//

import Foundation
import SwiftData

class StorageClient: ObservableObject {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func likedImage(for url: String) throws -> BreedImage? {
        do {
            let predicate = #Predicate<BreedImage> { object in
                object.url == url
            }
            var fetchDescriptor = FetchDescriptor<BreedImage>(predicate: predicate)
            fetchDescriptor.fetchLimit = 1
            let likedImages = try modelContext.fetch(fetchDescriptor)
            
            return likedImages.first
        } catch {
            throw DogBreedsError.storageError(error: error)
        }
    }
    
    func imageLiked(for url: String) -> Bool {
        guard let _ = try? likedImage(for: url) else {
            return false
        }
        return true
    }
    
    func likedImages(for breed: Breed) throws -> [BreedImage] {
        do {
            let name = breed.name
            let type = breed.type
            let predicate = #Predicate<BreedImage> { breedImage in
                breedImage.breed.name == name && breedImage.breed.type == type
            }
            let fetchDescriptor = FetchDescriptor<BreedImage>(predicate: predicate)
            let likedImages = try modelContext.fetch(fetchDescriptor)
            
            return likedImages
        } catch {
            throw DogBreedsError.storageError(error: error)
        }
    }
    
    func hasLikedImages(breed: Breed) -> Bool {
        guard let likedImages = try? likedImages(for: breed) else {
            return false
        }
        return !likedImages.isEmpty
    }
    
    func LikedImages() throws -> [BreedImage] {
        do {
            let fetchDescriptor = FetchDescriptor<BreedImage>()
            let likedImages = try modelContext.fetch(fetchDescriptor)
            return likedImages
        } catch {
            throw DogBreedsError.storageError(error: error)
        }
    }
    
    func addLikedImage(from breedImage: BreedImage) throws {
        do {
            breedImage.likedDate = Date()
            modelContext.insert(breedImage)
            try save()
        } catch {
            throw DogBreedsError.storageError(error: error)
        }
    }
    
    func removeLikedImage(with url: String) throws {
        do {
            try modelContext.delete(model: BreedImage.self, where: #Predicate { $0.url == url })
            try save()
        } catch {
            throw DogBreedsError.storageError(error: error)
        }
    }
    
    func removeAllLikedImages() throws {
        do {
            try modelContext.delete(model: BreedImage.self)
            try save()
        } catch {
            throw DogBreedsError.storageError(error: error)
        }
    }
    
    private func save() throws {
        if modelContext.hasChanges {
            try modelContext.save()
        }
    }
}
