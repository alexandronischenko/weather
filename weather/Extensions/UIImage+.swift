//
//  UIImage_.swift
//  weather
//
//  Created by Alexandr Onischenko on 27.02.2024.
//

import Foundation
import UIKit

extension UIImage {
    static func scope() -> UIImage {
        UIImage(systemName: "magnifyingglass") ?? UIImage()
    }

    static func location() -> UIImage {
        UIImage(systemName: "location.fill") ?? UIImage()
    }
}
