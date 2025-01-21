//
//  MapDetailScreen.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 21/01/2025.
//

import SwiftUI
import MapKit

struct MapDetailScreen: View {
    
    // MARK: - Properties
    let city: City
    var showInfo: Bool = false
    var showMap: Bool = false
    
    var isFavoriteImage: String {
        city.isFavorite ? "star.fill" : "star"
    }
    
    var isFavoriteValue: String {
        city.isFavorite ? "Mark as favorite" : "None"
    }
    
    var body: some View {
        VStack {
            if showMap {
                Map {
                    Annotation(
                        "\(city.name)",
                        coordinate: CLLocationCoordinate2D(
                            latitude: city.coordinates.latitude,
                            longitude: city.coordinates.longitude
                        ),
                        anchor: .bottom
                    ) {
                        Image(systemName: "mappin")
                            .resizable()
                            .foregroundColor(.purple)
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .edgesIgnoringSafeArea(.all)
            }

            if showInfo {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Title:")
                            .font(.headline)
                        Text("\(city.title)")
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Cordinates:")
                            .font(.headline)
                        Text("\(city.subtitle)")
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Cordinates:")
                            .font(.headline)
                        Text("\(city.country)")
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Favorite:")
                            .font(.headline)
                        Image(systemName: isFavoriteImage)
                            .font(.caption)
                        Text(isFavoriteValue)
                            .font(.caption)
                    }
                }
                .padding()
                .cornerRadius(8)
                .shadow(radius: 8)
            }
            
        }

    }
}

#Preview {
    NavigationStack {
        MapDetailScreen(city: City.previewItem)
    }
}
