//
//  BaseCoordinator.swift
//  flowerz
//
//  Created by Кузнецов Олег on 09.07.2023.
//

import Foundation

public typealias Block<T> = (T) -> Void

/// Базовый класс. Содержит основные методы и механизмы для реализации концепции `parent -> child`
open class BaseCoordinator<ResultType> {

    // MARK: - Public properties
    
    /// Вызывается координатором в момент окончания его флоу
    public var onComplete: Block<ResultType>?

    // MARK: - Private properties
    
    /// Идентификатор координатора
    private let identifier = UUID()
    
    /// `child`-координаторы.
    /// Необходимо для поддержания жизненного цикла `child`-координатора.
    private var childCoordinators: [UUID: Any] = [:]
    
    // MARK: - Init
    
    public init() {}
    
    // MARK: - Public methods
    
    /// Запускает новый координатор. Удерживает ссылку на него с момента запуска и отпускает в момент
    /// окончания.
    /// - Parameter coordinator: Координатор, на который будет осуществлен переход
    open func coordinate<T>(to coordinator: BaseCoordinator<T>) {
        store(coordinator: coordinator)
        let completion = coordinator.onComplete
        coordinator.onComplete = { [weak self, weak coordinator] value in
            completion?(value)
            if let coordinator = coordinator {
                self?.free(coordinator: coordinator)
            }
        }
        coordinator.start()
    }

    /// Абстрактный метод. Запускает флоу координатора.
    open func start() {
        fatalError("Абстрактный метод. Метод обязательно должен был перегружен в наследнике.")
    }

    /// Освобождает все childCoordinators
    public func cleanUpChildCoordinators() {
        childCoordinators.removeAll()
    }
    
    // MARK: - Private methods
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators.removeValue(forKey: coordinator.identifier)
    }
}

public extension BaseCoordinator {
    func onCompleteWhenClose(returning value: ResultType) -> Block<Void>{
        return { [weak self] _ in
            self?.onComplete?(value)
        }
    }
}
