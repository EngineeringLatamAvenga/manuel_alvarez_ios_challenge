//
//  CityListScreen.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 21/01/2025.
//

import SwiftUI
import SwiftData

struct CityListScreen: View {
    
    // MARK: - Propiedades
    @Environment(\.modelContext) private var modelContext
    @Query private var savedCities: [Favorite]
    
    @Environment(CitiesViewModel.self) private var citiesViewModel
    @State private var searchText: String = ""
    @State private var filteredCities: [City] = []
    @State private var selectedCity: City?
    @State private var navigationSelection: NavigationItem? = nil
    @State private var showFavoritesOnly: Bool = false

    // MARK: - Métodos Privados
    private func filterCities(with prefix: String) {
        citiesViewModel.searchCities(prefix: prefix) { result in
            self.filteredCities = result
        }
    }
    
    private func applyFilter() {
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                if self.searchText.isEmpty {
                    filteredCities = citiesViewModel.cities
                } else {
                    filterCities(with: searchText)
                }
            }
        }
    }
    
    private func isFavorite(_ city: City) -> Bool {
        return savedCities.contains { $0.cityId == city.id }
    }
    
    private func addFavorite(_ city: City) {
        let favorite = Favorite(city: city)
        modelContext.insert(favorite)
        saveContext()
    }
    
    private func removeFavorite(_ city: City) {
        if let favorite = savedCities.first(where: { $0.cityId == city.id }) {
            modelContext.delete(favorite)
            saveContext()
        }
    }
    
    private func toggleFavorite(_ city: City) {
        if isFavorite(city) {
            removeFavorite(city)
        } else {
            addFavorite(city)
        }
    }
    
    private func saveContext() {
        do {
            try modelContext.save()
            print("Favorites saved successfully!")
        } catch {
            print("Error to save in context: \(error.localizedDescription)")
        }
    }

    @ViewBuilder
    private func favoriteButton(for city: City) -> some View {
        Button(action: {
            toggleFavorite(city)
        }) {
            Image(systemName: isFavorite(city) ? "star.fill" : "star")
                .foregroundColor(isFavorite(city) ? .yellow : .gray)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(isFavorite(city) ? "Added to Favorites" : "Add to favorite")
    }

    var body: some View {
        ZStack {
            NavigationSplitView {
                if citiesViewModel.isLoading {
                    ProgressView("Loading...")
                        .accessibilityIdentifier("LoadingIndicator")
                } else {
                    if filteredCities.isEmpty {
                        EmptyView(title: "No cities matching your search", icon: "mappin.slash.circle.fill")
                    } else {
                        List(filteredCities.filter { !showFavoritesOnly || isFavorite($0) }, selection: $navigationSelection) { city in
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Button(action: {
                                            navigationSelection = .map(city)
                                        }) {
                                            CityCellView(city: city)
                                        }
                                        Spacer()
                                        favoriteButton(for: city)
                                        .accessibilityIdentifier("CityName_\(city.name)")
                                    }
                                    
                                    Button(action: {
                                        navigationSelection = .info(city)
                                    }) {
                                        HStack {
                                            Image(systemName: "info.circle")
                                            Text("More Info...")
                                                .font(.subheadline)
                                        }
                                        .foregroundColor(.purple)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .accessibilityIdentifier("More Info Button \(city.name)") 
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(8)
                            }
                        }
                        .navigationTitle("Cities")
                        .navigationBarTitleDisplayMode(.large)
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
                    try await citiesViewModel.loadAllCities()
                    applyFilter()
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
            .searchable(text: $searchText, prompt: "Type a city name")
            .onChange(of: searchText) { applyFilter() }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showFavoritesOnly.toggle()
                    }) {
                        Image(systemName: showFavoritesOnly ? "star.fill" : "star")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .padding()
                            .background(showFavoritesOnly ? Color.purple : Color.secondary)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .accessibilityLabel(showFavoritesOnly ? "Show favorites" : "Show all cities")
                    .padding()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CityListScreen()
            .environment(CitiesViewModel(httpClient: HTTPClient()))
    }
}
