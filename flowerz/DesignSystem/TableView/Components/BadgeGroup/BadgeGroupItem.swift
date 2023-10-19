//
//  BadgeGroupItem.swift
//  flowerz
//
//  Created by Кузнецов Олег on 02.08.2023.
//

extension UniversalTableView.Components {
    
    final class BadgeGroup: Item {
        
        /// Тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        /// Компонент составной. Теги передаются в модель
        var tag: String? = nil
        /// Тип секции
        var type: ItemType { .badgeGroup }
        /// Модель
        var model: [Components.BadgeGroup.Badge]
        
        /// Секция Засыхающие цветы.
        /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
        /// - Parameter model: Модель
        init(model: [Components.BadgeGroup.Badge]) {
            self.model = model
        }
    }
}
