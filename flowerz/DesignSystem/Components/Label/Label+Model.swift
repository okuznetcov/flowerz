//
//  Label+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.08.2023.
//

import UIKit

// MARK: - Components.Label + Model
 
extension Components.Label {
    
    // MARK: - Nested Types
    
    /// Константы
    private enum Consts {
        /// Шрифт по-умолчанию. Paragraph 12 Regular 0.0
        static let defaultFont: UIFont = Font.get(size: 12, weight: .regular)
    }
    
    // MARK: - Model
    
    /// Модель лейбла
    public enum Model {
        
        /// Простой текст. Предопределенный стиль Paragraph 12 Regular 0.0. Цвет текста textSecondary
        case text(String)
        /// Текст со ссылкой. На нажатие реагирует весь компонент целиком. Предопределенный стиль Paragraph 12 Regular 0.0. Цвет текста textSecondary
        case textWithLink(text: String, linkText: String)
        /// Кастомный стиль. На нажатие реагирует весь компонент целиком.
        case custom(Config)
        
        func asConfig() -> Config {
            switch self {
                case .text(let text):
                    return .init(
                        text: text,
                        linkText: nil,
                        font: Consts.defaultFont,
                        style: .secondary,
                        alignment: .left
                    )
                
                case .textWithLink(let text, let linkText):
                    return .init(
                        text: text,
                        linkText: linkText,
                        font: Consts.defaultFont,
                        style: .secondary,
                        alignment: .left
                    )
                
                case .custom(let configuration):
                    return configuration
            }
        }
    }
    
    // MARK: - Model Config
    
    /// Конфигурация лейбла
    public struct Config {
        
        /// Стиль (цвет текста)
        enum Style {
            /// Черный
            case primary
            /// Серый
            case secondary
            /// Кастомный цвет
            case custom(UIColor)
            
            /// Возвращает переданный стиль (цвет текста) как UIColor
            /// - Returns: цвет UIColor
            func asColor() -> UIColor {
                switch self {
                    case .primary:
                        return Color.textPrimary
                    
                    case .secondary:
                        return Color.textSecondary
                    
                    case .custom(let color):
                        return color
                }
            }
        }
        
        /// Текст в лейбле
        let text: String
        /// Текст в лейбле, который будет подсвечен как ссылка (на нажатие реагирует весь компонент целиком)
        let linkText: String?
        /// Шрифт
        let font: UIFont
        /// Стиль (цвет текста)
        let style: Style
        /// Выравнивание текста
        let alignment: NSTextAlignment
    }
}
