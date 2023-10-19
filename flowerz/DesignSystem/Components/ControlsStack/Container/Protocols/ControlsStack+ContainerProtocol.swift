//
//  ControlsStackContainer.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.09.2023.
//

// MARK: - ControlsStackContainer

/// Протокол контейнера контролов.
/// Гарантирует наличие свойства selectionStyle в контейнере, для того чтобы
/// все контролы в контейнере имели одинаковый стиль отметки выбора
public protocol ControlsStackContainer {
    
    /// Стиль отметки выбора (радиобаттон (выбор только одного варианта) / чекбокс (множественный выбор))
    var selectionStyle: Components.SelectionMark.Style { get }
}
