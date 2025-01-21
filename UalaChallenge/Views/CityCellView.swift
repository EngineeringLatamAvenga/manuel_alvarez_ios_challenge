//
//  CityCellView.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import SwiftUI

struct CityCellView: View {
    let city: City
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(city.title)
                    .font(.title)
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
