//
//  CityListScreen.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 21/01/2025.
//

import SwiftUI
import MapKit

struct MapDetailScreen: View {
    
    // MARK: - Properties
    @Binding var city: City?
    @Binding var detailNavigation: DetailsNavigation


    var body: some View {
        if let city = city {
            switch detailNavigation {
            case .map:
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )), annotationItems: [city]) { city in
                    MapMarker(coordinate: CLLocationCoordinate2D(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude), tint: .purple)
                }
                .mapStyle(.standard(elevation: .realistic))
                .edgesIgnoringSafeArea(.all)
            case .info:
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("Title:")
                            .font(.headline)
                        Text(city.title)
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Coordinates:")
                            .font(.headline)
                        Text("\(city.coordinates.latitude), \(city.coordinates.longitude)")
                            .font(.caption)
                    }
                    
                    HStack {
                        Text("Country:")
                            .font(.headline)
                        Text(city.country)
                            .font(.caption)
                    }
                }
                .padding()
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(8)
                .shadow(radius: 8)
            }
        } else {
            WelcomeView()
        }
    }
}
