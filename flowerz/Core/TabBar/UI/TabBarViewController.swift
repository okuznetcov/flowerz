//
//  TabBarViewController.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import UIKit

final class TabBarViewController: UITabBarController, TabBarModuleInput, TabBarModuleOutput {

     var onSelectedTab: ((Int, Int) -> Void)?

    /// Хранит индекс предыдущего таба, с которого будет осуществлен переход
    var previousTabIndex: Int = 0

    override var childForStatusBarStyle: UIViewController? {
        selectedViewController
    }

    override var childForStatusBarHidden: UIViewController? {
        selectedViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        tabBar.unselectedItemTintColor = Color.controlInactiveTabBar
        tabBar.tintColor = Color.controlActiveTabBar
        tabBar.isTranslucent = true
    }
}

// MARK: UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let newSelectedIndex = selectedIndex
        onSelectedTab?(newSelectedIndex, previousTabIndex)
        previousTabIndex = selectedIndex
    }
}
