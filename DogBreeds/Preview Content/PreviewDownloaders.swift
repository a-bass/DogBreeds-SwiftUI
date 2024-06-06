//
//  PreviewDownloaders.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-21.
//

import Foundation

#if DEBUG

class PreviewBreedsDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return previewBreedsListAllData
    }
}

class PreviewRandomBreedImageDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return previewBreedRandomData
    }
}

class PreviewBreedImagesDownloader: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))
        return previewBySubBreedData
    }
}

#endif
