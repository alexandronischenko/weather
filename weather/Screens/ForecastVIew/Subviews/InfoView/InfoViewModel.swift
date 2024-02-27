//
//  InfoViewModel.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation

final class InfoViewModel: ObservableObject {
    @Published var city: String
    @Published private var degree: Int
    @Published var condition: IconCondition

    lazy var temp: String = {
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: Double(degree), unit: UnitTemperature.celsius)
        formatter.unitStyle = .long
        formatter.locale = Locale.current
        formatter.unitStyle = .medium
        return formatter.string(from: measurement)
    }()

    init(city: String, degree: Int, condition: String) {
        self.city = city.localizedUppercase
        self.degree = degree
        self.condition = IconCondition.castToCondition(iconName: condition.camelized)
    }
}
