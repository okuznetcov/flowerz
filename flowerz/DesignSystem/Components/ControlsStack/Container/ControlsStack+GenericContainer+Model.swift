//
//  ControlsStack+Model.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.09.2023.
//

extension Components.ControlsStack.GenericContainer {
    
    /// Модель компонента. Хранит тексты контролов и настройки.
    /// Модели контролов могут разниться, т. к. контейнер группы принимает в себя любой ControlsStackEntity в качестве Generic.
    /// Для изменения отметок выбора см. selectedItems и методы компонента
    public struct Model {
        /// Массив контролов
        var controls: [ControlEntity.Model]
        /// Стиль отметки выбора (радиобаттон (выбор только одного варианта) / чекбокс (множественный выбор))
        var selectionStyle: Components.SelectionMark.Style
        /// Тактильный отклик при нажатии на контрол
        var performsHapticFeedback: Bool
    }
}
