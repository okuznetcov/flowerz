//
//  MainScreenItem.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.07.2023.
//

import Foundation

// MARK: - MainScreenItem

/// Элемент на главной приложения
protocol UniversalTableViewItem {

    /// Тип элемента
    var type: UniversalTableViewItemType { get }
    
    /// Количество строк в элементе
    var rowCount: Int { get }
    
    /// Порядок на экране
    var order: Int { get }
    
    /// Header секции таблицы (опционально)
    var header: UniversalTableView.Components.Header.Config? { get }
    
    /// Тэг элемента
    var tag: String? { get }
}

// MARK: - MainScreenItem + Predefined

extension UniversalTableViewItem {
    
    /// Количество строк в элементе главного экрана по-умолчанию
    //var tag: String? { return nil }
    
    /// Количество строк в элементе главного экрана по-умолчанию
    var rowCount: Int { return 1 }
    
    /// Порядок на экране
    var order: Int { return 0 }
    
    /// Заголовок секции таблицы
    var header: UniversalTableView.Components.Header.Config? { return nil }
}

typealias DesignComponents = Components
typealias TableViewComponents = UniversalTableView.Components

extension UniversalTableView {
    struct Model {
        let items: [UniversalTableViewItem]
    }
}
