//
//  MainViewModel.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation
import Combine

final class ForecastViewModel: ObservableObject {
    @Published var itemsByTheDay: [DayViewModel] = []
    @Published var itemsByTheHour: [HourViewModel] = []
    @Published var info: [InfoViewModel] = []
    @Published var city: City

    private var anyCancelable: Set<AnyCancellable> = []

    public init(info: [InfoViewModel],
                days: [DayViewModel],
                hours: [HourViewModel]) {
        self.itemsByTheDay = days
        self.itemsByTheHour = hours
        self.info = info
        self.city = Constants.Data.cities[.zero]
    }

    public init(city: City) {
        self.city = city
    }

    func fetchData() {
        WeatherRepository.shared.getForecast(in: self.city).sink { completion in
        } receiveValue: { [weak self] weather in
            self?.clearData()
            self?.setData(weather: weather)
        }
        .store(in: &anyCancelable)
    }

    func fetchDataFromLocation() {
        WeatherRepository.shared.getForecast().sink { completion in
        } receiveValue: { [weak self] weather in
            self?.clearData()
            self?.setData(weather: weather)
        }
        .store(in: &anyCancelable)
    }

    func setData(weather: Weather) {
        let info = InfoViewModel(city: weather.geoObject.locality.name,
                                 degree: weather.fact.temp,
                                 condition: weather.fact.condition)
        self.info = [info]

        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)

        var hours: [HourViewModel] = []
        for i in hour..<weather.forecasts[0].hours.count {
            let model = HourViewModel(time: weather.forecasts[0].hours[i].hour,
                                      temp: weather.forecasts[0].hours[i].temp,
                                      condition: weather.forecasts[0].hours[i].condition)
            hours.append(model)
        }

        for i in 0..<hour {
            let model = HourViewModel(time: weather.forecasts[1].hours[i].hour,
                                      temp: weather.forecasts[1].hours[i].temp,
                                      condition: weather.forecasts[1].hours[i].condition)
            hours.append(model)
        }
        self.itemsByTheHour = hours

        var days: [DayViewModel] = []
        for i in 0..<7 {
            let model = DayViewModel(
                date: weather.forecasts[i].date,
                dayTemp:  weather.forecasts[i].parts.day.temp,
                nightTemp: weather.forecasts[i].parts.night.temp,
                dayCondition: weather.forecasts[i].parts.day.condition,
                nightCondition: weather.forecasts[i].parts.night.condition)
            days.append(model)
        }
        self.itemsByTheDay = days
    }

    func clearData() {
        info = []
        itemsByTheDay = []
        itemsByTheHour = []
    }
}
