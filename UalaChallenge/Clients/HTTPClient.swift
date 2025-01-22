//
//  HTTPClient.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import Foundation

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    case delete
    case put(Data?)
    
    var name: String {
        switch self {
            case .get:
                return "GET"
            case .post:
                return "POST"
            case .delete:
                return "DELETE"
            case .put:
                return "PUT"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get([])
    var headers: [String: String]? = nil
    var modelType: T.Type
}

protocol HTTPClientProtocol {
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T
}
struct HTTPClient: HTTPClientProtocol {
    
    private let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        self.session = URLSession(configuration: configuration)
    }
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        
        var request = URLRequest(url: resource.url)
        
        // Set HTTP method and body if needed
        switch resource.method {
            case .get(let queryItems):
                var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
                components?.queryItems = queryItems
                guard let url = components?.url else {
                    throw NetworkError.badRequest
                }
                request.url = url
                
            case .post(let data), .put(let data):
                request.httpMethod = resource.method.name
                request.httpBody = data
                
            case .delete:
                request.httpMethod = resource.method.name
        }
        
        // Set custom headers
        if let headers = resource.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Check for specific HTTP errors
        switch httpResponse.statusCode {
            case 200...299:
                break // Success
            default:
                let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                throw NetworkError.errorResponse(errorResponse)
        }
        
        do {
            let result = try JSONDecoder().decode(resource.modelType, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}

class DevelopmentHTTPClient: HTTPClientProtocol {
    
    // Static instance for development (previews)
    static var development: DevelopmentHTTPClient {
        return DevelopmentHTTPClient()
    }
    
    // Sample data to return during development
    private let sampleCities: [City] = City.cityItems
    
    // Implement the required method from HTTPClientProtocol
    func load<T>(_ resource: Resource<T>) async throws -> T where T : Decodable, T : Encodable {
        // Ensure that the expected type is [City]
        guard T.self == [City].self else {
            fatalError("DevelopmentHTTPClient only supports responses for [City].")
        }
            
        // Return sample data
        return sampleCities as! T
    }
}
