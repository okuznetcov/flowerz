//
//  Coordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Swinject

/// Базовый координатор. Обертка над BaseCoordinator.
/// !! Для фичей предлагается использовать NavigationCoordinator !!
open class Coordinator<ResultType>: BaseCoordinator<ResultType> {
    
    // MARK: - Public properties
    
    /// Resolver, с помощью которого извлекаются зависимости
    public var resolver: Resolver {
        (assembler.resolver as? Container)?.synchronize() ?? assembler.resolver
    }
    
    /// Ассемблер
    var assembler: Assembler!

    // MARK: - Public methods
    
    /// Вызывает новый координатор
    /// - Parameters:
    ///   - coordinator: координатор, в который будет осуществлен переход
    open override func coordinate<T>(to coordinator: BaseCoordinator<T>) {
        if let coordinator = coordinator as? Coordinator<T> {
            let childAssembler = Assembler(parentAssembler: assembler)
            childAssembler.apply(assemblies: coordinator.assemblies())
            coordinator.assembler = childAssembler
        }
        super.coordinate(to: coordinator)
    }

    /// Массив `Assembly`, которые должны присутствовать в текущем координаторе и не существуют в родительском контейнере
    open func assemblies() -> [Assembly] {
        []
    }
}
