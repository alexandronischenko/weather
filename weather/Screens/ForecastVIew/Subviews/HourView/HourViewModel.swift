//
//  HourViewModel.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation
import Combine

class HourViewModel: Identifiable, ObservableObject {
    var id = UUID()
    var time: String
    var condition: IconCondition

    private var temp: Int
    private var cancellable: AnyCancellable?

    lazy var formattedTime: String = {
        let formatter = DateFormatter()

        formatter.dateFormat = DateFormatter.hour
        formatter.locale = .current
        guard let date = formatter.date(from: time) else { return DateFormatter.errorFormatting }

        formatter.dateFormat = DateFormatter.hourMin
        return formatter.string(from: date)
    }()

    lazy var formattedTemp: String = {
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: Double(temp), unit: UnitTemperature.celsius)
        formatter.unitStyle = .long
        formatter.locale = Locale.current
        formatter.unitStyle = .medium
        return formatter.string(from: measurement)
    }()

    init(time: String, temp: Int, condition: String) {
        self.time = time
        self.temp = temp
        self.condition = IconCondition.castToCondition(iconName: condition.camelized)
    }
}
