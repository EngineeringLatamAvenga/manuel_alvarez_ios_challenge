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
    }
}

#Preview {
    CityCellView(city: City.previewItem)
}


