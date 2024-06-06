//
//  ResponseDecodingTests.swift
//  DogBreedsTests
//
//  Created by Anders Lindskog on 2024-05-27.
//

import XCTest
@testable import DogBreeds

final class ResponseDecodingTests: XCTestCase {
    
    func testDictResponseDecodesDict() throws {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(DictResponse.self, from: previewBreedsListAllData)
        
        XCTAssertEqual(decoded.status, "success")
        XCTAssertEqual(decoded.message.count, 4)
        XCTAssertEqual(decoded.message["affenpinscher"]?.count, 0)
        XCTAssertEqual(decoded.message["bulldog"]?.count, 3)
        XCTAssertEqual(decoded.message["bulldog"]?.first, "boston")
        XCTAssertEqual(decoded.message["bulldog"]?.last, "french")
    }
    
    func testStringResponseDecodesString() throws {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(StringResponse.self, from: previewBreedRandomData)
        
        XCTAssertEqual(decoded.status, "success")
        XCTAssertEqual(decoded.message, "https://images.dog.ceo/breeds/bulldog-boston/n02096585_1307.jpg")
    }
    
    func testArrayResponseDecodesArray() throws {
        let decoder = JSONDecoder()
        let decoded = try decoder.decode(ArrayResponse.self, from: previewBySubBreedData)
        
        XCTAssertEqual(decoded.status, "success")
        XCTAssertEqual(decoded.message.count, 4)
        XCTAssertEqual(decoded.message.first, "https://images.dog.ceo/breeds/bulldog-boston/20200710_175933.jpg")
        XCTAssertEqual(decoded.message.last, "https://images.dog.ceo/breeds/bulldog-boston/n02096585_10452.jpg")
    }
}
