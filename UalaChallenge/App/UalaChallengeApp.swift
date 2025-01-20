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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CityListScreen()
        }
        .environment(CitiesStore(httpClient: .development))
        .modelContainer(sharedModelContainer)
    }
}
