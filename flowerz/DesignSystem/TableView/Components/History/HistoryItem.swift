//
//  MainScreen+History.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.07.2023.
//

import Foundation

// MARK: - MainScreen + History

extension UniversalTableView.Components {
    
    /// Секция История ухода за растениями.
    /// Карточки с записью о дате полива, опрыскивании и пересадке
    class History: Item {
        
        /// Тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        var tag: String?

        /// Тип секции
        var type: ItemType { .history }
        
        /// Header секции (опционально)
        var header: Header.Config? {
            guard let text = sectionTitle else { return nil }
            return .init(style: .large, text: text)
        }
        
        /// Массив моделей в секции
        var models: [Components.History.Model]
        
        /// Число строк в секции
        var rowCount: Int { return models.count }
        
        /// Текст в заголовке секции
        let sectionTitle: String?
        
        /// Секция История ухода за растениями.
        /// Карточки с записью о дате полива, опрыскивании и пересадке
        /// - Parameters:
        ///   - models: массив моделей в одной секции
        ///   - sectionTitle: число строк в секции
        ///   - tag: тег элемента. При взаимодействии с элементом будет передан в качетсве аргумента.
        init(
            models: [Components.History.Model],
            sectionTitle: String?,
            tag: String
        ) {
            self.models = models
            self.sectionTitle = sectionTitle
            self.tag = tag
        }
    }
}
