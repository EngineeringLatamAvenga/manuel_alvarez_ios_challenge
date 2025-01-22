//
//  WelcomeView.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 21/01/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome Uala Challenge")
            Text("Please select a city from the left-hand menu, swipe from the left edge to show it")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.secondary)
        }
        .padding()
        
    }
}

#Preview {
    WelcomeView()
}
