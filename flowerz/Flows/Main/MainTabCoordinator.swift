//
//  MainTabCoordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Foundation
import Swinject

final class MainTabCoordinator: TabBarItemCoordinator {
    override func assemblies() -> [Assembly] {
        [MainTabModuleAssembly()]
    }
    
    override func start() {
        let module = resolver.resolve(MainTabModule.self)!
        navigation?.setViewControllers([module.view], animated: false)
        
        guard let care = CareCoordinator(from: self, transition: .popOver) else { return }
        
        module.output.didTapButton = { [weak self] in
            self?.coordinate(to: care)
        }
    }
}
