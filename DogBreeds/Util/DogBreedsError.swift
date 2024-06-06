//
//  DogBreedsError.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-21.
//

import Foundation

enum DogBreedsError: Error {
    case storageError(error: Error)
    case networkError
    case urlError
    case parsingError(error: Error)
}

extension DogBreedsError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .storageError(let error):
            return String(localized: "Storage error: \(error.localizedDescription)", comment: "Error - storage")
        case .networkError:
            return String(localized: "Error fetching data over the network.", comment: "Error - network")
        case .urlError:
            return String(localized: "Invalid URL.", comment: "Error - url")
        case .parsingError(let error):
            return String(localized: "Error parsing data: \(error.localizedDescription)", comment: "Error - parsing")
        }
    }
}
