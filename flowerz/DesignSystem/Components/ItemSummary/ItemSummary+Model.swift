//
//  ItemSummary+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.08.2023.
//

import UIKit

// MARK: - Components.ItemSummary + Model

extension Components.ItemSummary {
    
    /// Модель компонента сводка по объекту
    public struct Model {
        
        /// Размер карточки с картинкой
        enum CardSize {
            /// Большая. Карточка с картинкой занимает половину экрана по ширине
            case large
            /// Средняя. Карточка с картинкой занимает треть экрана по ширине
            case medium
            case exact
        }
        
        /// Массив полей, которые будут отображаться справа (лейблы с заголовками)
        let fields: [Components.LabelWithName.Model]
        /// Карточка с картинкой, заголовком, подзаголовком и опциональной тенью которая будет отображаться слева
        let card: Components.ImageWithNameCard.Model
        /// Кнопка под списком полей. Необязательно
        let button: Components.Button.Model?
        /// Отображать ли отметку выбора в карточке слева
        let isSelected: Bool
        /// Размер карточки с картинкой
        let cardSize: CardSize
    }
}
