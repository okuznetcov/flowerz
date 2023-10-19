//
//  MainScreen+Title.swift
//  flowerz
//
//  Created by Кузнецов Олег on 18.07.2023.
//

import Foundation

// MARK: - MainScreen + Title

extension UniversalTableView.Components {
    
    /// Заголовок
    /// Ячейка с заголовоком и подзаголовком с выравниванием по центру
    final class Title: Item {
        
        /// Тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        var tag: String? = nil
        
        /// Тип секции
        var type: ItemType { .title }
        
        /// Модель
        var model: Components.Title.Model
        
        /// Заголовок
        /// Ячейка с заголовоком и подзаголовком с выравниванием по центру
        /// - Parameter model: Модель
        init(model: Components.Title.Model) {
            self.model = model
        }
    }
}
