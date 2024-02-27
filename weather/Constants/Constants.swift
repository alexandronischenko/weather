//
//  Constants.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation

struct Constants {

    private init() {}
    struct Data {
        static let cities = [
            City(id: 0,
                 name: Localizable.moscow.localized,
                 coordinate: Coordinate(lat: 55.75, lon: 37.62)),
            City(id: 1,
                 name: Localizable.kazan.localized,
                 coordinate: Coordinate(lat: 55.79, lon: 49.12)),
            City(id: 2,
                 name: Localizable.saintPetersburg.localized,
                 coordinate: Coordinate(lat: 59.94, lon: 30.31)),
            City(id: 3,
                 name: Localizable.krasnodar.localized,
                 coordinate: Coordinate(lat: 45.04, lon: 38.98)),
            City(id: 4,
                 name: Localizable.rostov.localized,
                 coordinate: Coordinate(lat: 47.23, lon: 39.72)),
            City(id: 5,
                 name: Localizable.london.localized,
                 coordinate: Coordinate(lat: 51.50, lon: -0.12)),
            City(id: 6,
                 name: Localizable.paris.localized,
                 coordinate: Coordinate(lat: 48.85, lon: -2.35)),
            City(id: 7,
                 name: Localizable.barcelona.localized,
                 coordinate: Coordinate(lat: 41.38, lon: 2.18)),
            City(id: 8,
                 name: Localizable.berlin.localized,
                 coordinate: Coordinate(lat: 52.51, lon: 13.37)),
            City(id: 9,
                 name: Localizable.warsaw.localized,
                 coordinate: Coordinate(lat: 52.23, lon: 21.00)),
            City(id: 10,
                 name: Localizable.minsk.localized,
                 coordinate: Coordinate(lat: 53.90, lon: 27.55)),
            City(id: 10,
                 name: Localizable.rome.localized,
                 coordinate: Coordinate(lat: 41.88, lon: 12.50)),
        ]
    }

    struct Offset {
        static let x05 = 8
        static let x = 16
        static let x2 = 32
        static let x3 = 48
        static let x4 = 64
        static let x5 = 80
        static let x6 = 96
    }
}
