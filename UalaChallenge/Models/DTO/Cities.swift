//
//  Cities.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import Foundation


struct City: Identifiable, Codable, Hashable {
    var id: Int { _id }
    let _id: Int
    var title: String { "\(name), \(country)" }
    var subtitle: String { "Lat: \(coordinates.latitude), Lon: \(coordinates.longitude)" }
    let name: String
    let country: String
    let coordinates: Coordinates
    
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
    
    static var cityItems: [City] = [
        City(
            _id: 707860,
            name: "Hurzuf",
            country: "UA",
            coordinates: Coordinates(longitude: 34.283333, latitude: 44.549999)
        ),
        City(
            _id: 519188,
            name: "Novinki",
            country: "RU",
            coordinates: Coordinates(longitude: 37.666668, latitude: 55.683334)
        ),
        City(
            _id: 1283378,
            name: "Gorkhā",
            country: "NP",
            coordinates: Coordinates(longitude: 84.633331, latitude: 28.0)
        ),
        City(
            _id: 1270260,
            name: "State of Haryāna",
            country: "IN",
            coordinates: Coordinates(longitude: 76.0, latitude: 29.0)
        ),
        City(
            _id: 708546,
            name: "Holubynka",
            country: "UA",
            coordinates: Coordinates(longitude: 33.900002, latitude: 44.599998)
        ),
        City(
            _id: 1283710,
            name: "Bāgmatī Zone",
            country: "NP",
            coordinates: Coordinates(longitude: 85.416664, latitude: 28.0)
        ),
        City(
            _id: 529334,
            name: "Mar’ina Roshcha",
            country: "RU",
            coordinates: Coordinates(longitude: 37.611111, latitude: 55.796391)
        ),
        City(
            _id: 1269750,
            name: "Republic of India",
            country: "IN",
            coordinates: Coordinates(longitude: 77.0, latitude: 20.0)
        ),
        City(
            _id: 1283240,
            name: "Kathmandu",
            country: "NP",
            coordinates: Coordinates(longitude: 85.316666, latitude: 27.716667)
        ),
        City(
            _id: 703363,
            name: "Laspi",
            country: "UA",
            coordinates: Coordinates(longitude: 33.733334, latitude: 44.416668)
        ),
        City(
            _id: 3632308,
            name: "Merida",
            country: "VE",
            coordinates: Coordinates(longitude: -71.144997, latitude: 8.598333)
        ),
        City(
            _id: 473537,
            name: "Vinogradovo",
            country: "RU",
            coordinates: Coordinates(longitude: 38.545555, latitude: 55.423332)
        ),
        City(
            _id: 384848,
            name: "Qarah Gawl al ‘Ulyā",
            country: "IQ",
            coordinates: Coordinates(longitude: 45.6325, latitude: 35.353889)
        ),
        City(
            _id: 569143,
            name: "Cherkizovo",
            country: "RU",
            coordinates: Coordinates(longitude: 37.728889, latitude: 55.800835)
        ),
        City(
            _id: 713514,
            name: "Alupka",
            country: "UA",
            coordinates: Coordinates(longitude: 34.049999, latitude: 44.416668)
        )
    ]
}
