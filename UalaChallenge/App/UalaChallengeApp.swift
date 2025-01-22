//
//  UalaChallengeApp.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 20/01/2025.
//

import SwiftUI
import SwiftData

@main
struct UalaChallengeApp: App {
    
    var viewModel: CitiesViewModel!

    init() {
        if CommandLine.arguments.contains("--uitesting") {
            // Inicializa con un cliente HTTP mockeado
            viewModel = CitiesViewModel(httpClient: DevelopmentHTTPClient())
        } else {
            // Inicializa con el cliente HTTP real
            viewModel = CitiesViewModel(httpClient: HTTPClient())
        }
    }
    
    var body: some Scene {
        WindowGroup {
            CityListScreen()
                .environment(viewModel)
                .modelContainer(for: [Favorite.self])
        }
    }
}
