//
//  Button+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.08.2023.
//

import UIKit

// MARK: - Components.Button + Model

extension Components.Button {
    
    typealias Feedback = UIImpactFeedbackGenerator.FeedbackStyle
    
    /// Модель кнопки
    public struct Model {
        /// Текст в кнопке
        let text: String
        /// Цвет текста кнопки
        let textColor: UIColor
        /// Цвет фона кнопки
        let color: UIColor
        /// Размер кнопки
        let size: Size
        /// Стиль кнопки
        let style: Style
        /// Будет ли вибрация при нажатии на кнопку (сила зависит от размера кнопки)
        let performsHapticFeedback: Bool
    }
    
    /// Размер кнопки
    public enum Size {
        /// Small Button h30 Paragraph 12 Medium 0.0
        case extraSmall
        /// Small Button h35 Paragraph 12 Medium 0.0
        case small
        /// Medium Button h40 Header 15 Semibold -0.5
        case medium
        /// Large Button h50 Header 20 Bold -0.5
        case large
        
        /// Возвращает параметры кнопки исходя из выбранного размера
        /// - Returns: параметры кнопки
        func parameters() -> SizeParameters {
            switch self {
                case .extraSmall:
                    return .init(typography: .p2Medium, height: 30, hapticFeedback: .light)
                
                case .small:
                    return .init(typography: .p2Medium, height: 35, hapticFeedback: .light)
                
                case .medium:
                    return .init(typography: .h3Semibold, height: 40, hapticFeedback: .light)
                    
                case .large:
                    return .init(typography: .h2Bold, height: 50, hapticFeedback: .medium)
            }
        }
    }
    
    /// Стиль кнопки
    public enum Style {
        /// Скругленные углы
        case rounded
        /// Полностью круглые углы
        case circular
    }
    
    /// Параметры размера кнопки
    struct SizeParameters {
        /// Типографика
        let typography: Typography
        /// Высота кнопки
        let height: CGFloat
        /// Вибрация
        let hapticFeedback: Feedback
    }
}
