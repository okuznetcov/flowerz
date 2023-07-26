//
//  ApplicationCoordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Foundation
import Swinject

/// Главный координатор приложения.
/// Запускается из SceneDelegate
final class ApplicationCoordinator: RootCoordinator {

    // MARK: - Public properties

    /// Синглтон
    public static var shared = ApplicationCoordinator()
    /// Окно
    public var window: UIWindow?
    
    // MARK: - Assembly
    
    override func assemblies() -> [Assembly] {
        return [TabBarModuleAssembly()]
    }
    
    // MARK: - Точка входа

    override func start() {
        
        /*
            NOTICE:
            Здесь может быть выполнено все, что необходимо сделать до
            до отрисовки интерфейса приложения.
         
            Далее будет вызван TabBarCoordinator где будет отрисован флоу каждого таба.
         */
        
        openTabBar()
    }
    
    // MARK: - Private methods
    
    /// Открывает TabBarCoordinator — главную приложения.
    private func openTabBar() {
        let tabBarCoordinator = TabBarCoordinator()
        tabBarCoordinator.window = window
        coordinate(to: tabBarCoordinator)
    }
}
