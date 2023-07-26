//
//  TabBarItemCoordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Swinject

/// Координатор для флоу которые являются вкладками в таббаре приложения
class TabBarItemCoordinator: Coordinator<Void> {
    
    /// NavigationController
    weak var navigation: UINavigationController?
    
    /// Dismiss'ит все ViewController'ы и очищает child-координаторы
    /// - Parameter animated: выполнять ли действие с анимацией
    func resetToRoot(animated: Bool) {
        if let presented = navigation?.presentedViewController {
            presented.dismiss(animated: animated, completion: nil)
        }
        navigation?.popToRootViewController(animated: animated)
        cleanUpChildCoordinators()
    }
}
