//
//  MainTabModuleAssembly.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Swinject

final class MainTabModuleAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MainTabModule.self) { _ in
            let presenter = MainTabPresenter()
            let view = MainTabViewController(output: presenter)
            presenter.viewInput = view
            //presenter.show()
            
            return MainTabModule(
                view: view,
                input: presenter,
                output: presenter
            )
        }
    }
}
