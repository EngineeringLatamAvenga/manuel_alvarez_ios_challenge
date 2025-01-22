//
//  UalaChallengeUITests.swift
//  UalaChallengeUITests
//
//  Created by Manny Alvarez on 20/01/2025.
//

import XCTest

final class MapDetailScreenUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = true
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    /// Prueba para navegar desde CityListScreen a MapDetailScreen en modo Info y verificar los elementos UI
    func testMapDetailScreenInfoView() throws {

        // Esperar a que el indicador de carga desaparezca
        let loadingIndicator = app.otherElements["LoadingIndicator"]
        let exists = NSPredicate(format: "exists == false")

        expectation(for: exists, evaluatedWith: loadingIndicator, handler: nil)
        waitForExpectations(timeout: 30, handler: nil)
        
        // Select a city
        let cityName = "Hurzuf"
        let countryName = "UA"
        // Tap "More Info..." for navigate to MapDetailScreen as mode .info
        let moreInfoButtonIdentifier = "More Info Button \(cityName)"
        let moreInfoButton = app.buttons[moreInfoButtonIdentifier]
        XCTAssertTrue(moreInfoButton.waitForExistence(timeout: 5), "Button '\(moreInfoButtonIdentifier)' should exist.")
        moreInfoButton.tap()
        
        // Verify the title
        let cityTitle = app.staticTexts["\(cityName), \(countryName)"]
        XCTAssertTrue(cityTitle.exists, "The title of the city should exist.")
        
        // VerifyCoordinates
        let coordinatesValues = "Lat: 44,549999, Long: 34,283333"
        let coordinatesText = app.staticTexts[coordinatesValues]
        XCTAssertTrue(coordinatesText.exists, "Coordinates shoud be displayed")
    }
}
