//
//  CityEntity.swift
//  UalaChallenge
//
//  Created by Manny Alvarez on 22/01/2025.

import Foundation
import SwiftData

@Model
class Favorite: Identifiable, Hashable {
    
    var id: UUID
    var cityId: Int

    init(city: City) {
        self.cityId = city._id
        self.id = UUID()
    }

    static func == (lhs: Favorite, rhs: Favorite) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
