//
//  MainScreen+PromoBanner.swift
//  flowerz
//
//  Created by Кузнецов Олег on 27.07.2023.
//

import Foundation

// MARK: - MainScreen + PromoBanner

extension UniversalTableView.Components {
    
    /// Промо-баннер с фоновым изображением и кнопкой. Большой и анимированный.
    /// Содержит заголовок, подзаголовок, опциональную кнопку
    final class PromoBanner: Item {
        
        /// Тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        var tag: String? = nil
        
        /// Тип секции
        var type: ItemType { .promoBanner }
        
        /// Модель
        var model: Components.PromoBanner.Model
        
        /// Промо-баннер с фоновым изображением и кнопкой. Большой и анимированный.
        /// Содержит заголовок, подзаголовок, опциональную кнопку
        /// - Parameter model: Модель ячейки
        /// - Parameter tag: тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        init(model: Components.PromoBanner.Model, tag: String?) {
            self.model = model
            self.tag = tag
        }
    }
}
