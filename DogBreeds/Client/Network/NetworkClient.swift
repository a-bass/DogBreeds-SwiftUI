//
//  DogBreedsClient.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-05.
//

import Foundation
import SwiftUI

class NetworkClient: ObservableObject {
    private lazy var decoder: JSONDecoder = {
        let aDecoder = JSONDecoder()
        return aDecoder
    }()

    private let downloader: any HTTPDataDownloader
    
    init(downloader: any HTTPDataDownloader = URLSession.shared) {
        self.downloader = downloader
    }
    
    func featuredBreedImageUrls() async throws -> [String] {
        var imageUrls = [String]()
        
        for _ in 1...5 {
            guard let apiUrl = URL(string: "https://dog.ceo/api/breeds/image/random"),
                    let imageUrl = try? await breedImageUrl(from: apiUrl) else {
                throw DogBreedsError.urlError
            }
            imageUrls.append(imageUrl)
        }
        
        return imageUrls
    }
    
    func breeds() async throws -> [Breed] {
        guard let url = URL(string: "https://dog.ceo/api/breeds/list/all") else {
            throw DogBreedsError.urlError
        }
        
        let data = try await downloader.httpData(from: url)
        let response = try decoder.decode(DictResponse.self, from: data)
        let messageSorted = response.message.sorted(by: { $0.key < $1.key })
        
        var breeds = [Breed]()
        for item in messageSorted {
            breeds.append(Breed(name: item.key))

            let valuesSorted =  item.value.sorted()
            for value in valuesSorted {
                breeds.append(Breed(name: item.key, type: value))
            }
        }
        
        return breeds
    }
    
    func breedImageUrls(for breed: Breed) async throws -> [String] {
        guard let url = URL(string: breed.imagesApiUrl) else {
            throw DogBreedsError.urlError
        }
        
        let data = try await downloader.httpData(from: url)
        let response = try decoder.decode(ArrayResponse.self, from: data)
        
        return response.message
    }
    
    func breedImageUrl(from apiUrl: URL) async throws -> String {
        let data = try await downloader.httpData(from: apiUrl)
        let response = try decoder.decode(StringResponse.self, from: data)
        return response.message
    }
}

extension Breed {
    
    private var typeSubdirectory: String {
        !type.isEmpty ? "/\(type)" : ""
    }
    
    var imagesApiUrl: String {
        return "https://dog.ceo/api/breed/\(name)\(typeSubdirectory)/images"
    }
    
    var randomImageApiUrl: String {
        return "\(imagesApiUrl)/random"
    }
}
