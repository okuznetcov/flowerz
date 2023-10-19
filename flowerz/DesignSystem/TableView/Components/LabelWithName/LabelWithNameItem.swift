//
//  LabelWithNameItem.swift
//  flowerz
//
//  Created by Кузнецов Олег on 02.08.2023.
//

/// Таблица на главной приложения
extension UniversalTableView.Components {
    
    final class LabelWithName: Item {
        
        /// Тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        var tag: String? = nil
        /// Тип секции
        var type: ItemType { .labelWithName }
        /// Модель
        var model: Components.LabelWithName.Model
        
        /// Секция Засыхающие цветы.
        /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
        /// - Parameter model: Модель
        init(model: Components.LabelWithName.Model) {
            self.model = model
        }
    }
}
