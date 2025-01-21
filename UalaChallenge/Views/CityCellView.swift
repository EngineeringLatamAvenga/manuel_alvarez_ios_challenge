//
//  CityCellView.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import SwiftUI

struct CityCellView: View {
    
    // MARK: Properties:
    let city: City
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NavigationLink(destination: MapDetailScreen(city: city, showMap: true)) {
                VStack(alignment: .leading) {
                    Text(city.title)
                        .font(.headline)
                    
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.purple)
                        Text(city.subtitle)
                    }
                }
            }
            .padding(.bottom, 16)
            .buttonStyle(PlainButtonStyle())
            
            NavigationLink(destination: MapDetailScreen(city: city, showInfo: true)) {
                HStack {
                    Image(systemName: "info.circle")
                    Text("More info...")
                        .font(.subheadline)
                }

            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        CityCellView(city: City.previewItem)
    }
}
