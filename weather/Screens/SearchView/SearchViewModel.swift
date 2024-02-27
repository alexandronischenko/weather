//
//  SearchViewModel.swift
//  weather
//
//  Created by Alexandr Onischenko on 27.02.2024.
//

import Foundation
import Combine
import UIKit

class SearchViewModel {
    @Published var cities = Constants.Data.cities
    @Published var city: City?
    var searchText: String = ""

    var searchResults: [City] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    init() {
    }

    func setCity(at index: Int) {
        city = searchResults[index]
    }
}
