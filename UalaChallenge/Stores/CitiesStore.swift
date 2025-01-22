//
//  CitiesStore.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import Foundation
import Observation

@Observable
class CitiesStore {
    
    let httpClient: HTTPClient
    private(set) var cities: [City] = []
    private(set) var filteredCities: [City] = []
    private(set) var isLoading: Bool = true
    
    private var cityIndex: [Character: [City]] = [:]
    

    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadAllCities() async throws {
        isLoading = true
        self.cities.removeAll()
        self.cityIndex.removeAll()
        let resource = Resource(url: Constants.Urls.cities, modelType: [City].self)
        let data = try await httpClient.load(resource).sorted { ($0.name, $0.country) < ($1.name, $1.country) }
        self.cities = data
        
        for city in data {
            let firstLetter = city.name.lowercased().first!
            if cityIndex[firstLetter] == nil {
                cityIndex[firstLetter] = []
            }
            cityIndex[firstLetter]?.append(city)
        }
        isLoading = false
    }

    func searchCities(prefix: String, completion: @escaping ([City]) -> Void) {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let firstLetter = prefix.lowercased().first else {
                DispatchQueue.main.async {
                    completion(self.cities)
                }
                return
            }
            let filteredCities = self.cityIndex[firstLetter]?.filter { $0.name.lowercased().starts(with: prefix.lowercased())} ?? []
            DispatchQueue.main.async {
                completion(filteredCities)
            }
        }
    }
}
