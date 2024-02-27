//
//  WeatherModels.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let info: Info
    let fact: Fact
    let forecasts: [Forecast]
    let geoObject: GeoObject

    enum CodingKeys: String, CodingKey {
        case info
        case fact
        case forecasts
        case geoObject = "geo_object"
    }

    init() {
        info = Info(url: "", lat: 0, lon: 0)
        fact = Fact(temp: 0, feelsLike: 0, icon: "", windSpeed: 0, condition: "")
        forecasts = []
        geoObject = GeoObject(locality: Locality(name: ""))
    }
}

struct GeoObject: Codable {
    let locality: Locality

    enum CodingKeys: String, CodingKey {
        case locality
    }
}

struct Locality: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
    }
}

// MARK: - Fact
struct Fact: Codable {
    let temp: Int
    let feelsLike: Int
    let icon: String
    let windSpeed: Double
    let condition: String

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case icon
        case windSpeed = "wind_speed"
        case condition
    }
}

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let hours: [Hour]
    let parts: Parts

    enum CodingKeys: String, CodingKey {
        case date
        case hours
        case parts
    }
}

// MARK: - Hour
struct Hour: Codable {
    let hour: String
    let temp: Int
    let feelsLike: Int
    let icon: String
    let condition: String

    enum CodingKeys: String, CodingKey {
        case hour
        case temp
        case feelsLike = "feels_like"
        case icon
        case condition
    }
}

struct Parts: Codable {
    let night: Day
    let day: Night

    enum CodingKeys: String, CodingKey {
        case night
        case day
    }
}

struct Day: Codable {
    let temp: Int
    let condition: String

    enum CodingKeys: String, CodingKey {
        case temp = "temp_avg"
        case condition
    }
}

struct Night: Codable {
    let temp: Int
    let condition: String

    enum CodingKeys: String, CodingKey {
        case temp = "temp_avg"
        case condition
    }
}


// MARK: - Info
struct Info: Codable {
    let url: String
    let lat, lon: Double

    enum CodingKeys: String, CodingKey {
        case url
        case lat
        case lon
    }
}
