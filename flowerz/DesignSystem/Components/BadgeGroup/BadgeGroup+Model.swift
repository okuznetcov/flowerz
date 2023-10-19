//
//  BadgeGroup+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.08.2023.
//

import UIKit

// MARK: - Components.BadgeGroup + Model

extension Components.BadgeGroup {
    
    /// Модель бейджа
    public struct Badge {
        /// Текст бейджа
        public let text: String
        /// Цвет бейджа
        public let color: UIColor
        
        /// Модель бейджа
        /// - Parameters:
        ///   - text: Текст бейджа
        ///   - color: Цвет бейджа
        init(text: String, color: UIColor) {
            self.text = text
            self.color = color
        }
    }
}
