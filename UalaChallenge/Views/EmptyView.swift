//
//  EmptyView.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 21/01/2025.
//

import SwiftUI

struct EmptyView: View {
    // MARK: Properties
    let title: String
    let icon: String
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color.purple)
                .padding()
            Text(title)
                .font(.subheadline)
                .foregroundStyle(Color.secondary)
        }
        
    }
}

#Preview {
    EmptyView(title: "No cities matching your search", icon: "mappin.slash.circle.fill")
}
