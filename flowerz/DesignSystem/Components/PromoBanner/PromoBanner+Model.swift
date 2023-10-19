//
//  PromoBanner+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.08.2023.
//

import UIKit

// MARK: - Components.PromoBanner + Model

extension Components.PromoBanner {
    
    /// Модель промо-баннера
    public struct Model {
        
        /// Cтиль промо-баннера
        public struct Style {
            
            /// Расположение кнопки
            enum ButtonPlacement {
                /// Внизу (прилипает к низу промо-баннера)
                case sticksToBottom
                /// После подзаголовка (прилипает к низу подзаголовка)
                case sticksToSubtitle
            }
            
            /// Высота (опционально). Если указана, баннер будет иметь размер с указанной высотой.
            /// Если не указана, баннер будет иметь высоту совпадающую с высотой переданной картинки, но не более 600pt.
            let height: CGFloat?
            /// Цвет текста
            let textColor: UIColor
            /// Расположение кнопки
            let buttonPlacement: ButtonPlacement
            /// Флаг, анимировать ли изображение
            let animatesImage: Bool
            /// Флаг, отображать ли тень над изображением
            let showsShadow: Bool
        }
        
        /// Заголовок
        let title: String
        /// Подзаголовок
        let subTitle: String
        /// Изображение
        let image: UIImage
        /// Кнопка (необязательно)
        let button: Components.Button.Model?
        /// Стиль
        let style: Style
    }
}
