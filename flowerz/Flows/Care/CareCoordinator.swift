//
//  CareCoordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 10.07.2023.
//

import Foundation
import Swinject

final class CareCoordinator: NavigationCoordinator<Void> {
    override func assemblies() -> [Assembly] {
        []
    }
    
    override func start() {
        let view = ViewController()
        show(view: view)
    }
}
