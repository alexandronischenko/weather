//
//  City.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation

struct City: Identifiable {
    let id: Int
    let name: String
    let coordinate: Coordinate

    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name
    }
}
