//
//  UIImage+safe.swift
//  flowerz
//
//  Created by Кузнецов Олег on 30.07.2023.
//

import UIKit

public extension UIImage {
    static func resolve(named name: String) -> UIImage {
        return UIImage(named: name) ?? UIImage()
    }
}
