//
//  Cities.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import Foundation


struct City: Identifiable, Codable {
    var id: Int
    var filterId: String { "\(name), \(country)" }
    var name: String
    var country: String
    var coordinates: Coordinates
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case coordinates = "coord"
        case name, country
    }
}

struct Coordinates: Codable {
    let longitude: Double
    let latitude: Double
    
    
    private enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

extension City {
    static var previewItem: City {
        .init(
            id: 5128638,
            name: "New York",
            country: "US",
            coordinates: .init(longitude: 75.49990, latitude: 43.000351)
        )
    }
}
