//
//  PreviewData.swift
//  DogBreeds
//
//  Created by Anders Lindskog on 2024-05-21.
//

import Foundation

#if DEBUG

let previewBreedsListAllData: Data = """
    {
        "message": {
            "affenpinscher": [],
            "bulldog": [
                "boston",
                "english",
                "french"
            ],
            "whippet": [],
            "wolfhound": [
                "irish"
            ]
        },
        "status": "success"
    }
    """.data(using: .utf8)!

let previewBreedRandomData: Data = """
    {
        "message": "https://images.dog.ceo/breeds/bulldog-boston/n02096585_1307.jpg",
        "status": "success"
    }
    """.data(using: .utf8)!

let previewBySubBreedData: Data = """
    {
        "message": [
            "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg",
            "https://images.dog.ceo/breeds/bulldog-boston/20200710_175944.jpg",
            "https://images.dog.ceo/breeds/bulldog-boston/n02096585_10380.jpg",
            "https://images.dog.ceo/breeds/bulldog-boston/n02096585_10452.jpg",
        ],
        "status": "success"
    }
    """.data(using: .utf8)!

#endif
