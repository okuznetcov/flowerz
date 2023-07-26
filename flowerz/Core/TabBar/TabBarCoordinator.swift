//
//  TabBarCoordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Foundation
import Swinject

// MARK: - TabBarCoordinator

/// Первый координатор приложения содержащий View.
/// Настраивает таббар и создает все флоу для табов.
/// Если нужно добавить новый таб, см. перечисление Tab
final class TabBarCoordinator: Coordinator<Void> {
    
    // MARK: - Public properties
    
    /// Окно приложения, в котором будет отображаться табы
    weak var window: UIWindow?
    
    // MARK: - Private properties
    
    /// NavigationController'ы для каждого таба
    private let tabNavigationControllers: [Tab: UINavigationController] =
    Tab.allCases.enumerated().reduce(into: [:]) { $0[$1.element] = UINavigationController() }
    
    /// ViewController, который будет rootViewController при старте приложения — он же является UITabBarController
    private weak var tabBarController: TabBarViewController?
    
    /// Табы, которые будут отображаться
    private let tabs: [Tab] = Tab.tabsToShow()
    
    /// Ошибки в координаторе
    private enum CoordinatorError: Error {
        case errorWhileResolvingNavigationForTab
    }
    
    // MARK: - Assembly
    
    override func assemblies() -> [Assembly] {
        [TabBarModuleAssembly()]
    }
    
    // MARK: - Точка входа
    
    /// Запускается при входе в координатор
    override func start() {
        let module = resolver.resolve(TabBarModule.self)!
        tabBarController = module.view as? TabBarViewController
        window?.rootViewController = module.view
        setupAllTabs()
    }
    
    // MARK: - Private methods
    
    /// Настраивает все табы в приложении
    private func setupAllTabs() {
        do {
            try tabs.forEach { try addTab($0) }
        } catch {
            assertionFailure("Ошибка резолва табов: \(error)")
        }
    }
    
    /// Добавляет таб с переданным кодом
    /// - Parameter tab: код таба, который необходимо добавить
    private func addTab(_ tab: Tab) throws {
        guard let navigation = tabNavigationControllers[tab] else {
            throw CoordinatorError.errorWhileResolvingNavigationForTab
        }
        navigation.tabBarItem = tab.getTabBarItem()
        let coordinator = tab.resolveCoordinator()
        coordinator.navigation = navigation
        coordinate(to: coordinator)
        tabBarController?.addChild(navigation)
    }
}
