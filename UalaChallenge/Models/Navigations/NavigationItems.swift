//
//  NavigationItems.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 22/01/2025.
//

import Foundation


enum NavigationItem: Hashable {
    case map(City)
    case info(City)
}

enum DetailsNavigation {
    case map
    case info
}

