//
//  DayViewModel.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation

class DayViewModel: Identifiable, ObservableObject {
    private var dayTemp: Int
    private var nightTemp: Int
    private var date: String

    var dayCondition: IconCondition
    var nightCondition: IconCondition
    var id = UUID()

    lazy var formattedDate: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.common
        guard let date = dateFormatter.date(from: date) else { return DateFormatter.errorFormatting }
        dateFormatter.locale = .current
        dateFormatter.dateFormat = DateFormatter.weekDay
        let dayInWeek = dateFormatter.string(from: date)

        return dayInWeek
    }()

    lazy var day: String = {
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: Double(dayTemp), unit: UnitTemperature.celsius)
        formatter.unitStyle = .long
        formatter.locale = Locale.current
        formatter.unitStyle = .medium
        return formatter.string(from: measurement)
    }()

    lazy var night: String = {
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: Double(nightTemp), unit: UnitTemperature.celsius)
        formatter.unitStyle = .long
        formatter.locale = Locale.current
        formatter.unitStyle = .medium
        return formatter.string(from: measurement)
    }()

    init(date: String, dayTemp: Int, nightTemp: Int, dayCondition: String, nightCondition: String) {
        self.date = date
        self.dayTemp = dayTemp
        self.nightTemp = nightTemp
        self.dayCondition = IconCondition.castToCondition(iconName: dayCondition.camelized)
        self.nightCondition = IconCondition.castToCondition(iconName: nightCondition.camelized)
    }
}
