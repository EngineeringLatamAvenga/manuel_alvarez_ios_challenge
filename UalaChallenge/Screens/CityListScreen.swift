//
//  CityListScreen.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import SwiftUI

struct CityListScreen: View {
    
    //MARK: - Properties:
    @Environment(CitiesStore.self) private var citiesStore
    @State private var searchText: String = ""
    @State private var filteredCities: [City] = []
    
    // MARK: - Private methods:
    private func filterCities(with prefix: String) {
        citiesStore.searchCities(prefix: prefix) { result in
            self.filteredCities = result
        }
    }
    
    private func applyFilter() {
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
        NavigationStack {
            ZStack {
                if citiesStore.isLoading {
                    ProgressView("Loading...")
                } else {
                    if filteredCities.isEmpty {
                        EmptyView(title: "No cities matching your search", icon: "mappin.slash.circle.fill")
                    } else {
                        ScrollView {
                            LazyVStack {
                                ForEach(filteredCities) { city in
                                    CityCellView(city: city)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .cornerRadius(8)
                                        
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Cities")
            .task {
                do {
                    try await citiesStore.loadAllCities()
                    applyFilter()
                } catch {
                    print(error.localizedDescription)
                }
            }
            .searchable(text: $searchText, prompt: "Search cities")
            .disabled(citiesStore.isLoading)
            .onChange(of: searchText) { applyFilter() }
        }
    }
}

#Preview {
    NavigationStack {
        CityListScreen()
            .environment(CitiesStore(httpClient: .development))
    }
}
