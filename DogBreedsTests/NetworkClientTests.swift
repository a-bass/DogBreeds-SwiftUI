//
//  NetworkClientTests.swift
//  DogBreedsTests
//
//  Created by Anders Lindskog on 2024-05-21.
//

import XCTest
@testable import DogBreeds

final class NetworkClientTests: XCTestCase {
    
    func testFeaturedBreedImageUrlsClient() async throws {
        let client = NetworkClient(downloader: PreviewRandomBreedImageDownloader())
        let imageUrls = try await client.featuredBreedImageUrls()

        XCTAssertEqual(imageUrls.count, 5)

        if let first = imageUrls.first {
            XCTAssertEqual(first, "https://images.dog.ceo/breeds/bulldog-boston/n02096585_1307.jpg")
        } else {
            XCTFail("No first item")
        }
        
        
        if let last = imageUrls.first {
            XCTAssertEqual(last, "https://images.dog.ceo/breeds/bulldog-boston/n02096585_1307.jpg")
        } else {
            XCTFail("No last item")
        }
    }
    
    func testBreedImageUrlClient() async throws {
        let client = NetworkClient(downloader: PreviewRandomBreedImageDownloader())
        let imageUrl = try await client.breedImageUrl(from: URL(string: BreedImage.preview.url)!)

        XCTAssertEqual(imageUrl, "https://images.dog.ceo/breeds/bulldog-boston/n02096585_1307.jpg")
    }
    
    func testBreedClient() async throws {
        let client = NetworkClient(downloader: PreviewBreedsDownloader())
        let breeds = try await client.breeds()
        
        XCTAssertEqual(breeds.count, 8)
        
        if let first = breeds.first {
            XCTAssertEqual(first.name, "affenpinscher")
            XCTAssertTrue(first.type.isEmpty)
            XCTAssertFalse(first.isSubBreed)
            XCTAssertEqual(first.displayName, "Affenpinscher")
            XCTAssertEqual(first.randomImageApiUrl, "https://dog.ceo/api/breed/affenpinscher/images/random")
            XCTAssertEqual(first.imagesApiUrl, "https://dog.ceo/api/breed/affenpinscher/images")
        } else {
            XCTFail("No first item")
        }
        
        if let last = breeds.last {
            XCTAssertEqual(last.name, "wolfhound")
            XCTAssertEqual(last.type, "irish")
            XCTAssertTrue(last.isSubBreed)
            XCTAssertEqual(last.displayName, "Wolfhound - Irish")
            XCTAssertEqual(last.randomImageApiUrl, "https://dog.ceo/api/breed/wolfhound/irish/images/random")
            XCTAssertEqual(last.imagesApiUrl, "https://dog.ceo/api/breed/wolfhound/irish/images")
        } else {
            XCTFail("No last item")
        }
    }
    
    func testBreedImageUrlsClient() async throws {
        let client = NetworkClient(downloader: PreviewBreedImagesDownloader())
        let breedImages = try await client.breedImageUrls(for: Breed.preview)

        XCTAssertEqual(breedImages.count, 4)
        
        if let first = breedImages.first {
            XCTAssertEqual(first, "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg")
        } else {
            XCTFail("No first item")
        }
        
        if let last = breedImages.last {
            XCTAssertEqual(last, "https://images.dog.ceo/breeds/bulldog-boston/n02096585_10452.jpg")
        } else {
            XCTFail("No last item")
        }
    }
}
