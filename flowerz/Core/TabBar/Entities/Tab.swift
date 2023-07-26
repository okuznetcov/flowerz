//
//  Tab.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import UIKit

// MARK: - Tab

/// Табы в приложении
public enum Tab: Int, CaseIterable {
    
    // MARK: - Виды табов
    
    /// Главная
    case main
    /// Еще
    case more
    
    // MARK: - Перечень и порядок табов, которые будут отображаться в приложении
    
    /// Возвращает массив табов, которые будут отрисованы.
    /// Тут же можно поменять порядок табов.
    public static func tabsToShow() -> [Tab] {
        return [.main, .more]
    }
    
    // MARK: - Как будут называться и отображаться табы внизу экрана
    
    /// Возвращает UITabBarItem для конкретного таба
    func getTabBarItem() -> UITabBarItem {
        switch self {
            case .main:
                return .init(title: "Главная", image: nil, tag: self.rawValue)
            case .more:
                return .init(title: "Еще", image: nil, tag: self.rawValue)
        }
    }
    
    // MARK: - Координаторы, которые будут отвечать за табы
    
    /// Возвращает координатор для конкретного таба
    func resolveCoordinator() -> TabBarItemCoordinator {
        switch self {
            case .main:
                return MainTabCoordinator()
            case .more:
                return MoreCoordinator()
        }
    }
}
