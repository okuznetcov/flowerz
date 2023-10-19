//
//  ControlsStack+EntityProtocol.swift
//  flowerz
//
//  Created by Кузнецов Олег on 03.09.2023.
//

import UIKit

// MARK: - ControlsStackEntity

/// Протокол экземпляра контрола в контейнере контролов
public protocol ControlsStackEntity: UIView {
    
    /// Модель контрола
    associatedtype Model: ControlsStackEntityModel
    
    /// Инициализатор контрола. С его помощью контейнер будет настраивать контрол
    /// - Parameters:
    ///   - container: контейнер, в котором будет размещен контрол
    ///   - model: модель контрола
    init(container: ControlsStackContainer, with model: Model)
    
    /// Отметка выбора контрола.
    /// При изменении компонент должен обновить свое состояние.
    var isSelected: Bool { get set }
    
    /// Вызывается при нажатии контрол
    var didTapOnControl: ((any ControlsStackEntity) -> Void)? { get set }
    
    /// Тег контрола
    var controlTag: String { get }
}

// MARK: - ControlsStackEntityModel

/// Модель экземпляра контрола
public protocol ControlsStackEntityModel {

    /// Тег контрола
    var tag: String { get }
}
