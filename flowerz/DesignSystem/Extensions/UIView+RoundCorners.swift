//
//  UIView+RoundCorners.swift
//  flowerz
//
//  Created by Кузнецов Олег on 12.07.2023.
//

import Foundation
import UIKit

// MARK: - UIView + MakeRoundCorners

public extension UIView {
    
    /// Скругляет углы View с нужным радиусом
    /// - Parameter radius: радиус скругления углов
    func makeRoundCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.cornerCurve = .continuous
    }
}
