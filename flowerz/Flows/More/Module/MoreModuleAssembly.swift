//
//  MoreModuleAssembly.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Swinject

final class MoreModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MoreModule.self) { _ in
            let viewController = MoreViewController()
            
            return MoreModule(
                view: viewController,
                input: (),
                output: ()
            )
        }
    }
}
