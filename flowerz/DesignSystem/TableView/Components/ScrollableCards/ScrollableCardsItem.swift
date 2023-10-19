//
//  MainScreen+ScrollableCardsWithImages.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.07.2023.
//

import Foundation

// MARK: - MainScreen + ScrollableCardsWithImages

extension UniversalTableView {
    enum Components {
        
        /// Элемент на главной приложения
        typealias Item = UniversalTableViewItem
        
        /// Тип элемента на главной приложения
        typealias ItemType = UniversalTableViewItemType
    }
}

/// Таблица на главной приложения
extension UniversalTableView.Components {
    
    /// Секция Засыхающие цветы.
    /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
    final class ScrollableCards: Item {
        
        /// Тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        /// Компонент составной. Теги передаются в модель.
        var tag: String? = nil
        /// Тип секции
        var type: ItemType { .scrollableCards }
        /// Header секции (опционально)
        var header: Header.Config? = .init(style: .small, text: "Без полива больше недели")
        /// Модель
        var model: Components.ScrollableCards.Model
        var order: Int = 1
        
        /// Секция Засыхающие цветы.
        /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
        /// - Parameter model: Модель
        init(model: Components.ScrollableCards.Model) {
            self.model = model
            //self.order = model.order
        }
    }
}
