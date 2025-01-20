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
    private(set) var myCities: [City] = []
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadAllCities() async throws {
        let resource = Resource(url: Constants.Urls.cities, modelType: [City].self)
        cities = try await httpClient.load(resource)
    }
    
}
