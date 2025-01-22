//
//  MockHTTPClient.swift
//  UalaChallengeTests
//
//  Created by Manny Alvarez on 22/01/2025.
//

import Foundation
@testable import UalaChallenge

class MockHTTPClient: HTTPClientProtocol {
    
    // Property to set the desired result for the mock
    var result: Result<[City], Error>?
    
    // Implement the required method from HTTPClientProtocol
    func load<T>(_ resource: Resource<T>) async throws -> T where T : Decodable, T : Encodable {
        // Ensure that the expected type is [City]
        guard T.self == [City].self else {
            fatalError("MockHTTPClient only supports responses for [City].")
        }
        // Return the mock result
        switch result {
        case .success(let cities):
            // Force cast since we've ensured T is [City]
            return cities as! T
        case .failure(let error):
            throw error
        case .none:
            fatalError("Result not set in MockHTTPClient.")
        }
    }
}
