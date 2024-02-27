//
//  Font+.swift
//  weather
//
//  Created by Alexandr Onischenko on 27.02.2024.
//

import Foundation
import UIKit

extension UIFont {
    static func common() -> UIFont {
        .systemFont(ofSize: 16, weight: .semibold)
    }

    static func cityLabel() -> UIFont {
        .systemFont(ofSize: 30, weight: .medium)
    }

    static func temperatureLabel() -> UIFont {
        .systemFont(ofSize: 50, weight: .semibold)
    }

    static func paragraphLabel() -> UIFont {
        .systemFont(ofSize: 24, weight: .medium)
    }
}
