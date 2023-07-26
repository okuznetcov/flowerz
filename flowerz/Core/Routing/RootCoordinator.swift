//
//  RootCoordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Swinject

/// Root коориднатор
open class RootCoordinator: Coordinator<Void> {

    public override init() {
        super.init()
        assembler = Assembler(assemblies())
    }
    
    public func removeAll() {
        if let container = assembler.resolver as? Container {
            container.removeAll()
        }
    }
}
