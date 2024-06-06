//
//  HTTPDataDownloader.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-21.
//

import Foundation

protocol HTTPDataDownloader {
    func httpData(from: URL) async throws -> Data
}

extension URLSession: HTTPDataDownloader {
    func httpData(from url: URL) async throws -> Data {
        let validStatus = 200...299
        
        guard let (data, response) = try await self.data(from: url, delegate: nil) as? (Data, HTTPURLResponse),
              validStatus.contains(response.statusCode) else {
            throw DogBreedsError.networkError
        }
        return data
    }
}
