//
//  MainScreenItemType.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.07.2023.
//

import Foundation

// MARK: - MainScreenItemType

/// Тип элемента на главной приложения
enum UniversalTableViewItemType {
    
    case labelWithName
    
    /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой
    case scrollableCards
    
    /// История ухода.
    /// Карточка с записью c привязкой к дате и перечню проведенных операций
    case history
    
    /// Заголовок
    /// Ячейка с заголовоком и подзаголовком с выравниванием по центру
    case title
    
    /// Баннер в различных стилях
    case banner
    
    /// Промо-баннер с фоновым изображением и кнопкой. Большой и анимированный.
    /// Содержит заголовок, подзаголовок, опциональную кнопку
    case promoBanner
    
    case itemSummary
    case button
    case badgeGroup

    enum TextWithLink { } //?
    enum LineSeparator { } //?
}
