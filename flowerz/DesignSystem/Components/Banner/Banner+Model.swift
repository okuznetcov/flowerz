//
//  Banner+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.08.2023.
//

import UIKit

// MARK: - Components.Banner + Model

extension Components.Banner {
    
    /// Модель баннера
    public struct Model {
        /// Заголовок (необязательно)
        let title: String?
        /// Подзаголовок (обязательно)
        let subTitle: String
        /// Стиль
        let style: Style
    }
    
    /// Стиль баннера
    public enum Style {
        /// Простой (заголовок + подзаголовок)
        case plain
        /// Изображение справа. Применяется маска по границам баннера.
        case rightImage(image: UIImage)
        /// Изображение-фон баннера. Применяется маска по границам баннера.
        case backgroundImage(image: UIImage)
    }
}
