//
//  CityListScreen.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 21/01/2025.
//

import SwiftUI

struct CityListScreen: View {
    
    //MARK: - Properties:
    @Environment(CitiesStore.self) private var citiesStore
    @State private var searchText: String = ""
    @State private var filteredCities: [City] = []
    @State private var selectedCity: City?
    @State private var navigationSelection: NavigationItem? = nil

    
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
        NavigationSplitView {
            if citiesStore.isLoading {
                ProgressView("Loading...")
            } else {
                if filteredCities.isEmpty {
                    EmptyView(title: "No cities matching your search", icon: "mappin.slash.circle.fill")
                } else {
                    List(filteredCities, selection: $navigationSelection) { city in
                        VStack(alignment: .leading, spacing: 8) {
                            Button(action: {
                                navigationSelection = .map(city)
                            }) {
                                CityCellView(city: city)
                            }
                            
                            Button(action: {
                                navigationSelection = .info(city)
                            }) {
                                HStack {
                                    Image(systemName: "info.circle")
                                    Text("More info...")
                                        .font(.subheadline)
                                        .foregroundColor(.primary)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                    
                    }
                    .navigationTitle("Cities")
                    .navigationDestination(for: NavigationItem.self) { navigationItem in
                        switch navigationItem {
                        case .info(let city):
                            MapDetailScreen(city: .constant(city), detailNavigation: .constant(.info))
                        case .map(let city):
                            MapDetailScreen(city: .constant(city), detailNavigation: .constant(.map))
                        }
                    }
                }
            }

        } detail: {
            if let navigationItem = navigationSelection {
                switch navigationItem {
                case .info(let city):
                    MapDetailScreen(city: .constant(city), detailNavigation: .constant(.info))
                case .map(let city):
                    MapDetailScreen(city: .constant(city), detailNavigation: .constant(.map))
                }
            } else {
                WelcomeView()
            }
        }
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

#Preview {
    NavigationStack {
        CityListScreen()
            .environment(CitiesStore(httpClient: .development))
    }
}
