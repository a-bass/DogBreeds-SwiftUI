//
//  StorageClientTests.swift
//  DogBreedsTests
//
//  Created by Anders Lindskog on 2024-05-30.
//

import XCTest
@testable import DogBreeds
import SwiftData

final class StorageClientTests: XCTestCase {
    
    @MainActor func client() throws -> StorageClient {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: BreedImage.self, configurations: config)
        
        return StorageClient(modelContext: container.mainContext)
    }
    
    @MainActor func testGetLikedImageForUrl() throws {
        let client = try client()
        XCTAssertEqual(try client.LikedImages().count, 0)
        
        try client.addLikedImage(from: BreedImage.preview)
        XCTAssertEqual(try client.LikedImages().count, 1)
        
        
        if let image = try client.likedImage(for: "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg") {
            XCTAssertEqual(image.breed.name, "bulldog")
            XCTAssertEqual(image.breed.type, "boston")
            XCTAssertEqual(image.url, "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg")
        } else {
            XCTFail("No item")
        }
        
        XCTAssertTrue(client.imageLiked(for: "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg"))
        XCTAssertFalse(client.imageLiked(for: ""))
    }
    
    @MainActor func testGetLikedImageArrayForBreed() throws {
        let client = try client()
        XCTAssertEqual(try client.LikedImages().count, 0)
        
        try client.addLikedImage(from: BreedImage.preview)
        XCTAssertEqual(try client.LikedImages().count, 1)
        
        if let firstArrayImage = try client.likedImages(for:  Breed.preview).first {
            XCTAssertEqual(firstArrayImage.breed.name, "bulldog")
            XCTAssertEqual(firstArrayImage.breed.type, "boston")
            XCTAssertEqual(firstArrayImage.url, "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg")
        } else {
            XCTFail("No first item")
        }
        
        XCTAssertTrue(client.hasLikedImages(breed: Breed.preview))
        XCTAssertFalse(client.hasLikedImages(breed: Breed(name: "bulldog"))) // Only name and no type
    }
    
    @MainActor func testGetAll() throws {
        let client = try client()
        XCTAssertEqual(try client.LikedImages().count, 0)
        
        try client.addLikedImage(from: BreedImage.preview)
        XCTAssertEqual(try client.LikedImages().count, 1)
        
        if let firstArrayImage = try client.LikedImages().first {
            XCTAssertEqual(firstArrayImage.breed.name, "bulldog")
            XCTAssertEqual(firstArrayImage.breed.type, "boston")
            XCTAssertEqual(firstArrayImage.url, "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg")
        } else {
            XCTFail("No first item")
        }
    }

    @MainActor func testAddFromBreedImage() throws {
        let client = try client()
        XCTAssertEqual(try client.LikedImages().count, 0)
        
        // First attempt: count = 1
        try client.addLikedImage(from: BreedImage.preview)
        XCTAssertEqual(try client.LikedImages().count, 1)
        
        // Second attempt, same url with different name: count still = 1
        let updatedBreedImage = BreedImage(url: BreedImage.preview.url, breed: Breed(name: ""))
        try client.addLikedImage(from: updatedBreedImage)
        XCTAssertEqual(try client.LikedImages().count, 1)
    }
    
    @MainActor func testRemoveFromBreedImage() throws {
        let client = try client()
        XCTAssertEqual(try client.LikedImages().count, 0)
        
        try client.addLikedImage(from: BreedImage.preview)
        XCTAssertEqual(try client.LikedImages().count, 1)
        
        // First attempt
        try client.removeLikedImage(with: BreedImage.preview.url)
        XCTAssertEqual(try client.LikedImages().count, 0)

        // Second attempt, url dos not exist
        try client.removeLikedImage(with: BreedImage.preview.url)
        XCTAssertEqual(try client.LikedImages().count, 0)
    }
    
   @MainActor func testRemoveAll() throws {
       let client = try client()
       XCTAssertEqual(try client.LikedImages().count, 0)
       
       try client.addLikedImage(from: BreedImage.preview)
       XCTAssertEqual(try client.LikedImages().count, 1)
       
       try client.removeAllLikedImages()
       XCTAssertEqual(try client.LikedImages().count, 0)
   }
}
