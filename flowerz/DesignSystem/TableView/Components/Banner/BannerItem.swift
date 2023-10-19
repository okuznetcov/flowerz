//
//  MainScreen+Banner.swift
//  flowerz
//
//  Created by Кузнецов Олег on 18.07.2023.
//

import Foundation

// MARK: - MainScreen + Banner

extension UniversalTableView.Components {
    
    /// Баннер в различных стилях
    final class Banner: Item {
        
        /// Тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        var tag: String?
        
        /// Тип секции
        var type: ItemType { .banner }
        
        /// Модель
        var model: Components.Banner.Model
        
        /// Баннер в различных стилях
        /// - Parameter model: Модель
        init(model: Components.Banner.Model, tag: String?) {
            self.model = model
            self.tag = tag
        }
    }
}
