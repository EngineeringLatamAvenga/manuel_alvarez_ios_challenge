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
    let city: City?

    var body: some View {
        NavigationStack {
            if let city = city {
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
            } else {
                EmptyView(title: "Please select a city", icon: "mappin.slash.circle.fill")
            }
        }
    }
}

#Preview {
    NavigationStack {
        MapDetailScreen(city: City.previewItem)
    }
}
