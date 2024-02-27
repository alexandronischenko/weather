//
//  WeatherRepository.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation
import Alamofire
import Combine

class WeatherRepository {
    static var shared = WeatherRepository()

    private var header: HTTPHeaders = ["X-Yandex-API-Key": "aa7894c1-0984-47be-86bb-45f792a46c1f"]

    private var path = "https://api.weather.yandex.ru/v2/forecast"

    private init() {}

    enum ErrorResponse: Error {
        case failedToGetData
    }

    func getForecast(in city: City, completion: @escaping ((Result<Weather, Error>) -> ())) {
        let loc = Locale.current.languageCode
        let lang = loc == "ru" ? "ru_RU" : "en_US"

        AF.request("\(path)?lat=\(city.coordinate.lat)&lon=\(city.coordinate.lon)&lang=\(lang)", headers: header).response { response in
            guard let data = response.data else {
                print("Failed to get")
                completion(.failure(ErrorResponse.failedToGetData))
                return
            }
            let decoder = JSONDecoder()
            guard let weather = try? decoder.decode(Weather.self, from: data) else {
                print("Failed to decode")
                completion(.failure(ErrorResponse.failedToGetData))
                return
            }
            completion(.success(weather))
        }
    }

    func getForecast(completion: @escaping ((Result<Weather, Error>) -> ())) {
        guard let lat = LocationManager.shared.userLocation?.coordinate.latitude,
              let lon = LocationManager.shared.userLocation?.coordinate.longitude else { return }

        let loc = Locale.current.languageCode
        let lang = loc == "ru" ? "ru_RU" : "en_US"

        AF.request("\(path)?lat=\(lat)&lon=\(lon)&lang=\(lang)", headers: header).response { response in
            guard let data = response.data else {
                print("Failed to get")
                completion(.failure(ErrorResponse.failedToGetData))
                return
            }
            let decoder = JSONDecoder()
            guard let weather = try? decoder.decode(Weather.self, from: data) else {
                print("Failed to decode")
                completion(.failure(ErrorResponse.failedToGetData))
                return
            }
            completion(.success(weather))
        }
    }

    func getForecast() -> AnyPublisher<Weather, Error> {
        guard let lat = LocationManager.shared.userLocation?.coordinate.latitude,
              let lon = LocationManager.shared.userLocation?.coordinate.longitude else {
            return Fail(error: ErrorResponse.failedToGetData).eraseToAnyPublisher()
        }

        let loc = Locale.current.languageCode
        let lang = loc == "ru" ? "ru_RU" : "en_US"

        let decoder = JSONDecoder()

        guard let url = URL(string: "\(path)?lat=\(lat)&lon=\(lon)&lang=\(lang)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        do {
            let request = try URLRequest(url: url, method: .get, headers: header)
            return URLSession.shared.dataTaskPublisher(for: request)
                .map{$0.data}
                .decode(type: Weather.self,
                        decoder: decoder)
                .receive(on: RunLoop.main)
                .mapError({ error in
                    ErrorResponse.failedToGetData
                })
                .eraseToAnyPublisher()
        }
        catch {
            return Fail(error: URLError(.requestBodyStreamExhausted)).eraseToAnyPublisher()
        }
    }
    
    func getForecast(in city: City) -> AnyPublisher<Weather, Error> {
        let loc = Locale.current.languageCode
        let lang = loc == "ru" ? "ru_RU" : "en_US"

        let lat = city.coordinate.lat
        let lon = city.coordinate.lon

        guard let url = URL(string: "\(path)?lat=\(lat)&lon=\(lon)&lang=\(lang)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        let decoder = JSONDecoder()

        do {
            let request = try URLRequest(url: url, method: .get, headers: header)
            return URLSession.shared.dataTaskPublisher(for: request)
//                .map{$0.data}
                .tryMap { element in
                    guard
                        let httpResponse = element.response as? HTTPURLResponse,
                        httpResponse.statusCode == 200 else
                    { throw URLError(.badServerResponse) }

                    return element.data
                }
                .decode(type: Weather.self,
                        decoder: decoder)
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        }
        catch {
            return Fail(error: URLError(.requestBodyStreamExhausted)).eraseToAnyPublisher()
        }
    }
}

