//
//  MoreCoordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Foundation
import Swinject

final class MoreCoordinator: TabBarItemCoordinator {
    override func assemblies() -> [Assembly] {
        [MoreModuleAssembly()]
    }
    
    override func start() {
        let module = resolver.resolve(MoreModule.self)!
        navigation?.setViewControllers([module.view], animated: false)
    }
}
