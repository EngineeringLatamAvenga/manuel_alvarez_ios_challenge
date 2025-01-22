//
//  Cities.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import Foundation


struct City: Identifiable, Codable, Hashable {
    let id = UUID()
    var _id: Int?
    var title: String { "\(name), \(country)" }
    var subtitle: String { "Lat: \(coordinates.latitude), Lon: \(coordinates.longitude)" }
    let name: String
    let country: String
    let coordinates: Coordinates
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case name, country, _id
    }
}

struct Coordinates: Codable, Hashable {
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
            _id: 1,
            name: "New York",
            country: "US",
            coordinates: .init(longitude: 75.49990, latitude: 43.000351)
        )
    }
}
