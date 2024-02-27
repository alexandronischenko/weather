//
//  Localizablel.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation

enum Localizable: String {

    enum languageCode: String {
        case ru = "ru"
        case en = "en"
    }

    case search = "search"
    case hourlyForecast = "text_hourly_forecast"
    case weeklyForecast = "text_weekly_forecast"
    case moscow = "moscow"
    case kazan = "kazan"
    case saintPetersburg = "saint_petersburg"
    case krasnodar = "krasnodar"
    case rostov = "rostov_on_don"
    case london = "london"
    case paris = "paris"
    case barcelona = "barcelona"
    case berlin = "berlin"
    case warsaw = "warsaw"
    case minsk = "minsk"
    case rome = "rome"

    case nothingFound = "nothing_found"
}

extension Localizable {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
