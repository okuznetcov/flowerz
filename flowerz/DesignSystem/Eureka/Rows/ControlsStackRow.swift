//
//  ControlsStackRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.08.2023.
//

import Eureka

public extension EurekaComponents.ControlsStack {
    
    /// Группа контролов в вертикальном стеке. Компонент Eureka.
    /// Поддерживается два типа контролов: радиобаттон (выбор только одного варианта) или чекбокс (множественный выбор)
    ///
    /// Модель хранит тексты контролов, а словарь selectedItems — перечень контролов с отметкой выбора.
    /// При изменении моделей компонент обновляется.
    final class ControlsStackRow<Entity: ControlsStackEntity>: Row<ControlsStackCell<Entity>>, RowType {
        
        public typealias Component = Components.ControlsStack.GenericContainer<Entity>
        
        /// Модель компонента.
        /// При изменении модели компонент обновляется
        public var model: Component.Model {
            didSet { cell.updateModel() }
        }
        
        /// Перечень контролов с отметкой выбора.
        /// При изменении компонент обновляется.
        ///
        /// ⚠️
        /// Не рекомендуется сеттить извне, т. к. свойство не содержит проверок на существование переданных тегов.
        /// Для изменения отметок выбора следует пользоваться методами
        ///
        /// - *changeSelectionForItemWith(tag: Control.Tag, isSelected: Bool)*
        ///
        /// - *changeSelectionForAllItems(isSelected: Bool)*
        /// 
        public var selectedItems: [String: Bool] {
            didSet { cell.updateSelectedItems() }
        }
        
        /// Вызывается при изменении выбора в компоненте
        public var didChangedSelection: (([String: Bool]) -> Void) {
            didSet { cell.updateSelectionClosure() }
        }
        
        /// Группа контролов в вертикальном стеке. Компонент Eureka.
        /// Поддерживается два типа контролов: радиобаттон (выбор только одного варианта) или чекбокс (множественный выбор)
        ///
        /// Модель хранит тексты контролов, а словарь selectedItems — перечень контролов с отметкой выбора.
        /// При изменении моделей компонент обновляется.
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - model: модель компонента
        ///   - selectedItems: перечень контролов с отметкой выбора
        ///   - didChangedSelection: вызывается при изменении выбора в компоненте
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Component.Model,
            selectedItems: [String: Bool],
            didChangedSelection: @escaping (([String: Bool]) -> Void),
            _ initializer: ((ControlsStackRow) -> Void)? = nil
        ) {
            self.model = model
            self.selectedItems = selectedItems
            self.didChangedSelection = didChangedSelection
            super.init(tag: tag)
            initializer?(self)
        }
        
        /// Обновляет отметку выбора для контрола с переданным тегом
        /// - Parameters:
        ///   - tag: тег контрола, для которого необходимо обновить отметку выбора
        ///   - isSelected: новая отметка выбора
        public func changeSelectionForItemWith(tag: String, isSelected: Bool) {
            cell.changeSelectionForItemWith(tag: tag, isSelected: isSelected)
        }
        
        /// Обновляет отметки выбора во всех контролах
        /// - Parameter isSelected: новая отметка выбора всех контролов
        public func changeSelectionForAllItems(isSelected: Bool) {
            cell.changeSelectionForAllItems(isSelected: isSelected)
        }
        
        required init(tag: String?) {
            fatalError("init(tag:) has not been implemented")
        }
    }
}

public extension EurekaComponents.ControlsStack {

    /// Группа контролов в вертикальном стеке. Ячейка Eureka.
    final class ControlsStackCell<Entity: ControlsStackEntity>: CustomCell<String, Components.ControlsStack.GenericContainer<Entity>>, CellType {
        
        /// Компонент Eureka
        private var typedRow: ControlsStackRow<Entity>? { row as? ControlsStackRow<Entity> }
        
        /// Настраивает ячейку
        public override func setup() {
            guard let typedRow = typedRow else { return }
            
            component = .init(model: typedRow.model)
            component?.selectedItems = typedRow.selectedItems
            component?.didChangedSelection = { [weak self] selection in
                self?.typedRow?.didChangedSelection(selection)
            }
            
            super.setup()
        }
        
        /// Обновляет перечень контролов с отметкой выбора.
        public func updateSelectedItems() {
            super.update()
            guard let typedRow = typedRow else { return }
            component?.selectedItems = typedRow.selectedItems
        }
        
        /// Обновляет замыкание изменения отметок выбора
        public func updateSelectionClosure() {
            super.update()
            component?.didChangedSelection = { [weak self] selection in
                self?.typedRow?.didChangedSelection(selection)
            }
        }
        
        /// Обновляет модель компонента
        public func updateModel() {
            super.update()
            guard let typedRow = typedRow else { return }
            component?.model = typedRow.model
            invalidateIntrinsicContentSize()
        }
        
        /// Обновляет отметку выбора для контрола с переданным тегом
        /// - Parameters:
        ///   - tag: тег контрола, для которого необходимо обновить отметку выбора
        ///   - isSelected: новая отметка выбора
        public func changeSelectionForItemWith(tag: String, isSelected: Bool) {
            component?.changeSelectionForItemWith(tag: tag, isSelected: isSelected)
        }
        
        /// Обновляет отметки выбора во всех контролах
        /// - Parameter isSelected: новая отметка выбора всех контролов
        public func changeSelectionForAllItems(isSelected: Bool) {
            component?.changeSelectionForAllItems(isSelected: isSelected)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
    }
}
