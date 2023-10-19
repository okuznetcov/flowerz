//
//  ButtonItem.swift
//  flowerz
//
//  Created by Кузнецов Олег on 02.08.2023.
//

extension UniversalTableView.Components {
    
    final class Button: Item {
        
        /// Тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        var tag: String? = nil
        /// Тип секции
        var type: ItemType { .button }
        /// Модель
        var model: Components.Button.Model
        
        /// Секция Засыхающие цветы.
        /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
        /// - Parameter model: Модель
        /// - Parameter tag: тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        init(model: Components.Button.Model, tag: String?) {
            self.model = model
            self.tag = tag
        }
    }
}
