//
//  Response.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-22.
//

import Foundation

class Response<T: Decodable>: Decodable {
    var status: String
    var message: T
    
    private enum CodingKeys: String, CodingKey {
        case message
        case status
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        status = try container.decode(String.self, forKey: .status)
        guard status != "\"success\"" else {
            throw DogBreedsError.networkError
        }
        
        do {
            message = try container.decode(T.self, forKey: .message)
        } catch {
            throw DogBreedsError.parsingError(error: error)
        }
    }
}

class StringResponse: Response<String> {
    required init(from decoder: any Decoder) throws {
        try super.init(from: decoder)
    }
}

class ArrayResponse: Response<[String]> {
    required init(from decoder: any Decoder) throws {
        try super.init(from: decoder)
    }
}

class DictResponse: Response<[String:[String]]> {
    required init(from decoder: any Decoder) throws {
        try super.init(from: decoder)
    }
}
