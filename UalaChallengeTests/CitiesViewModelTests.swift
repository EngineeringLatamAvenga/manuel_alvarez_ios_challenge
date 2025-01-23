//
//  UalaChallengeTests.swift
//  UalaChallengeTests
//
//  Created by Manny Alvarez on 20/01/2025.
//

import XCTest
@testable import UalaChallenge

final class CitiesViewModelTests: XCTestCase {
    
    var viewModel: CitiesViewModel!
    var mockHTTPClient: MockHTTPClient!
    
    override func setUp() {
        super.setUp()
        mockHTTPClient = MockHTTPClient()
        viewModel = CitiesViewModel(httpClient: mockHTTPClient)
    }
    
    override func tearDown() {
        viewModel = nil
        mockHTTPClient = nil
        super.tearDown()
    }
    
    func testLoadAllCitiesSuccess() async throws {
        // Arrange
        let cities = City.cityItems
        mockHTTPClient.result = .success(cities)
        
        // Act
        try await viewModel.loadAllCities()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after loading.")
        XCTAssertEqual(viewModel.cities, City.cityItems.sorted { ($0.name, $0.country) < ($1.name, $1.country) }, "Cities should be sorted correctly.")
        
        // Verify the 'h' key contains both "Holubynka" and "Hurzuf"
        let expectedHCities = City.cityItems.filter { $0.name.lowercased().starts(with: "h") }.sorted { $0.name < $1.name }
        XCTAssertEqual(viewModel.cityIndex["h"], expectedHCities, "cityIndex for 'h' should contain Holubynka and Hurzuf.")
    }
    
    func testLoadAllCitiesFailure() async throws {
        // Arrange
        enum TestError: Error {
            case fetchFailed
        }
        mockHTTPClient.result = .failure(TestError.fetchFailed)
        
        // Act & Assert
        do {
            try await viewModel.loadAllCities()
            XCTFail("The function should throw an error.")
        } catch {
            XCTAssertFalse(viewModel.isLoading, "isLoading should be false after an error.")
            XCTAssertTrue(viewModel.cities.isEmpty, "cities should be empty in case of an error.")
            XCTAssertTrue(viewModel.cityIndex.isEmpty, "cityIndex should be empty in case of an error.")
        }
    }
    
    func testCityIndexPopulation() async throws {
        // Arrange
        let cities = [
            City(_id: 1, name: "Atlanta", country: "USA", coordinates: Coordinates(longitude: 76.0, latitude: 29.0)),
            City(_id: 2, name: "Austin", country: "USA", coordinates: Coordinates(longitude: 76.0, latitude: 29.0)),
            City(_id: 3, name: "Boston", country: "USA", coordinates: Coordinates(longitude: 76.0, latitude: 29.0)),
            City(_id: 4, name: "Berlin", country: "Germany", coordinates: Coordinates(longitude: 76.0, latitude: 29.0))
        ]
        mockHTTPClient.result = .success(cities)
        
        // Act
        try await viewModel.loadAllCities()
        
        // Assert
        XCTAssertEqual(viewModel.cityIndex["a"], [cities[0], cities[1]], "Cities starting with 'a' should be grouped correctly.")
        
        // Update the expected order for 'b' group to match the sorting logic
        let expectedBCities = [cities[3], cities[2]].sorted {
            ($0.name, $0.country) < ($1.name, $1.country)
        }
        XCTAssertEqual(viewModel.cityIndex["b"], expectedBCities, "Cities starting with 'b' should be grouped correctly.")
    }
    
    func testLoadAllCitiesEmptyList() async throws {
        // Arrange
        mockHTTPClient.result = .success([])
        
        // Act
        try await viewModel.loadAllCities()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after loading.")
        XCTAssertTrue(viewModel.cities.isEmpty, "cities should be empty.")
        XCTAssertTrue(viewModel.cityIndex.isEmpty, "cityIndex should be empty.")
    }
    
    func testSearchCities_WithSingleResult() async throws {
        // Arrange
        mockHTTPClient.result = .success(City.cityItems)
    
        // Act
        try await viewModel.loadAllCities()
        
        viewModel.searchCities(prefix: "Holu") { filteredCities in
            // Assert
            XCTAssertEqual(filteredCities.count, 1, "Shoud be return only one city.")
            XCTAssertEqual(filteredCities.first?.name, "Holubynka", "The city shoud be Holubynka.")
        }
    }
    
    func testSearchCities_WithMultipleResults() async throws {
        // Arrange
        mockHTTPClient.result = .success(City.cityItems)
        
        // Act
        try await viewModel.loadAllCities()
        
        viewModel.searchCities(prefix: "Al") { filteredCities in
            // Assert
            XCTAssertEqual(filteredCities.count, 2, "Shoud be return 2 cites.")
            XCTAssertEqual(filteredCities.first?.name, "Alabama", "The city shoud be Alabama.")
        }
    }
    
    func testSearchCities_CaseInsensitive() async throws {
        // Arrange
        mockHTTPClient.result = .success(City.cityItems)
        // Act
        try await viewModel.loadAllCities()
        
        viewModel.searchCities(prefix: "ala") { filteredCities in
            // Assert
            XCTAssertEqual(filteredCities.count, 1, "Shoud be return 1 city.")
            XCTAssertEqual(filteredCities.first?.name, "Alabama", "The city shoud be Alabama.")
        }
    }
    
    func testSearchCities_WithNoResults() async throws {
        // Arrange
        mockHTTPClient.result = .success(City.cityItems)
        
        // Act
        try await viewModel.loadAllCities()
        
        viewModel.searchCities(prefix: "XYZ") { filteredCities in
            // Assert
            XCTAssertEqual(filteredCities.count, 0, "Return empty.")
        }
    }
}
