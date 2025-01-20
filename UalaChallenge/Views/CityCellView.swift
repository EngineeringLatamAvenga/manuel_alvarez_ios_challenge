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
        VStack {
            Text(city.filterId)
                .font(.title)
        }
    }
}

#Preview {
    CityCellView(city: City.previewItem)
}
