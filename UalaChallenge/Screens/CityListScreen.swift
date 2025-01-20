//
//  CityListScreen.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import SwiftUI

struct CityListScreen: View {
    
    //MARK: Properties:
    @Environment(CitiesStore.self) private var citiesStore
    
    var body: some View {
        List(citiesStore.cities) { city in
            CityCellView(city: city)
        }
        .task {
            do {
                try await citiesStore.loadAllCities()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CityListScreen()
    }
    .environment(CitiesStore(httpClient: .development))
}
