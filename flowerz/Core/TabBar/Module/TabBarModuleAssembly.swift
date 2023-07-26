//
//  TabBarModuleAssembly.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Swinject

final class TabBarModuleAssembly: Assembly {
    public func assemble(container: Container) {
        container.register(TabBarModule.self) { _ in
            let controller = TabBarViewController()

            return .init(
                view: controller,
                input: controller,
                output: controller
            )
        }
        .inObjectScope(.weak)
    }
}
