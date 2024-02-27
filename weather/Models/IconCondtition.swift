//
//  IconCondtition.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation

enum IconCondition: String {
    case sunMax = "sun.max"
    case overcast = "cloud.fill"
    case cloud = "cloud"
    case cloudDrizzleFill = "cloud.drizzle.fill"
    case cloudRainFill = "cloud.rain.fill"
    case cloudHeavyRainFill = "cloud.heavyrain.fill"
    case cloudSnowFill = "cloud.snow.fill"
    case cloudBoltFill = "cloud.bolt.fill"
    case cloudSunFill = "cloud.sun.fill"
    case cloudSunRainFill = "cloud.sun.rain.fill"
    case smokeFill = "smoke.fill"
}

extension IconCondition {
    static func castToCondition(iconName: String) -> IconCondition {
        switch iconName {
        case "clear": return IconCondition.sunMax
        case "partly-cloudy": return IconCondition.cloudSunFill
        case "cloudy": return IconCondition.cloud
        case "overcast": return IconCondition.overcast
        case "partly-cloudy-and-light-rain": return IconCondition.cloudSunRainFill
        case "partly-cloudy-and-rain": return IconCondition.cloudRainFill
        case "cloudy-and-light-rain": return IconCondition.cloudDrizzleFill
        case "overcast-and-light-rain": return IconCondition.cloudDrizzleFill
        case "cloudy-and-rain": return IconCondition.cloudRainFill
        case "overcast-thunderstorms-with-rain": return IconCondition.cloudHeavyRainFill
        case "overcast-and-wet-snow ": return IconCondition.cloudDrizzleFill
        case "overcast-and-snow": return IconCondition.cloudSnowFill
        case "partly-cloudy-and-light-snow": return IconCondition.cloudSnowFill
        case "cloudy-and-light-snow": return IconCondition.cloudSnowFill
        case "overcast-and-light-snow": return IconCondition.cloudSnowFill
        case "cloudy-and-snow": return IconCondition.cloudSnowFill
        default:
            return .sunMax
        }
    }
}
