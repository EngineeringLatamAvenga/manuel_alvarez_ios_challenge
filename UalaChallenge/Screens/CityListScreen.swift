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
    @State private var searchText: String = ""
    @State private var filteredCities: [City] = []
    
    
    private func filterCities(with prefix: String) {
        citiesStore.searchCities(prefix: prefix) { result in
            self.filteredCities = result
        }
    }
    
    private func resetValues() {
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                if self.searchText.isEmpty {
                    filteredCities = citiesStore.cities
                } else {
                    filterCities(with: searchText)
                }
            }
        }
    }
    
    
    var body: some View {
        ZStack {
            if citiesStore.isLoading {
                ProgressView("Loading...")
            } else {
                List(filteredCities) { city in
                    CityCellView(city: city)
                }
            }
        }
        .navigationTitle("Cities")
        .task {
            do {
                try await citiesStore.loadAllCities()
                resetValues()
            } catch {
                print(error.localizedDescription)
            }
        }
        .searchable(text: $searchText, prompt: "Search cities")
        .onChange(of: searchText) { resetValues() }
    }
}

#Preview {
    NavigationStack {
        CityListScreen()
            .environment(CitiesStore(httpClient: .development))
    }
}
