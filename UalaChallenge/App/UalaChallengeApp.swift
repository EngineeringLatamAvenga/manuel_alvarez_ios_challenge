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
    
    var body: some Scene {
        WindowGroup {
            CityListScreen()
                .environment(CitiesStore(httpClient: .development))
                .modelContainer(for: [Favorite.self])
        }
    }
}
