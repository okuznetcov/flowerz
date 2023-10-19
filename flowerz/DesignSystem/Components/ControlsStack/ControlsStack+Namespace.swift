//
//  ControlsStack+Namespace.swift
//  flowerz
//
//  Created by Кузнецов Олег on 03.09.2023.
//

import Foundation

extension Components {
    
    /// Группа контролов в вертикальном стеке.
    /// Ячейки могут быть различными, т. к. контейнер группы принимает в себя любой ControlsStackEntity в качестве Generic.
    ///
    /// Поддерживается два три типа контролов:
    /// - radiobutton (выбор только одного варианта),
    /// - checkmark (выбор только одного варианта, как в радиобатоне, но вместо круга будет галочка)
    /// - checkbox (множественный выбор),
    ///
    /// Модель хранит тексты контролов, а словарь selectedItems — перечень контролов с отметкой выбора.
    /// При изменении моделей компонент обновляется.
    public enum ControlsStack { }
}

extension Components.ControlsStack {
    public enum Entity { }
}
