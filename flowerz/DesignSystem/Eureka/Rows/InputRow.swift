//
//  InputRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 03.08.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.Input {
    
    /// Поле ввода текста в одну строку с подписью под полем ввода. Компонент Eureka.
    /// Поддерживает разные типы клавиатур.
    /// Введенный текст содержится в row.value. При изменении величин компонент обновляется.
    final class InputRow: Row<InputCell>, RowType {
        
        // MARK: - Public properties
        
        /// Модель поля ввода.
        /// При изменении модели компонент обновляется.
        public var model: Components.BaseInput.Model? {
            didSet { updateCell() }
        }
        
        /// Текст под полем ввода.
        /// При изменении компонент обновляется.
        public var bottomCaption: String? {
            didSet { updateCell() }
        }
        
        /// Флаг, пусто ли поля ввода
        public var isEmpty: Bool {
            cell.component?.isEmpty ?? false
        }
        
        /// Вызывается, когда текст в поле ввода был изменен
        public var didChangedText: (() -> Void)? {
            didSet { updateCell() }
        }
        
        /// Вызывается при старте взаимодействия с полем (компонент становится firstResponder)
        public var didStartEditing: (() -> Void)? {
            didSet { updateCell() }
        }
        
        /// Вызывается при окончании взаимодействия с полем (компонент прекращает быть firstResponder)
        public var didFinishEditing: (() -> Void)? {
            didSet { updateCell() }
        }
        
        /// Поле ввода текста в одну строку с подписью под полем ввода. Компонент Eureka.
        /// Поддерживает разные типы клавиатур.
        /// Введенный текст содержится в row.value. При изменении величин компонент обновляется.
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - model: модель поля ввода
        ///   - value: значение в поле ввода по-умолчанию
        ///   - bottomCaption: текст под полем ввода по-умолчанию
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.BaseInput.Model?,
            value: String?,
            bottomCaption: String?,
            _ initializer: ((InputRow) -> Void)? = nil
        ) {
            super.init(tag: tag)
            self.model = model
            self.value = value
            self.bottomCaption = bottomCaption
            cellStyle = .default
            initializer?(self)
        }
        
        required init(tag: String?) {
            fatalError("init(tag:) has not been implemented")
        }
    }
}

public extension EurekaComponents.Input {
    
    /// Поле ввода текста в одну строку. Ячейка Eureka.
    final class InputCell: CustomCell<String, Components.Input>, CellType {
        
        // MARK: - Private properties
        
        /// Компонент Eureka
        private var typedRow: InputRow? { row as? InputRow }
        
        /// Настраивает ячейку
        public override func setup() {
            component = .init()
            updateValues()
            super.setup()
        }
        
        /// Обновляет ячейку
        public override func update() {
            super.update()
            updateValues()
            invalidateIntrinsicContentSize()
        }
        
        /// Обновляет величины в компоненте дизайн-системы (proxy)
        private func updateValues() {
            guard let typedRow = typedRow else { return }
            component?.model = typedRow.model
            component?.text = typedRow.value
            component?.bottomCaption = typedRow.bottomCaption
            
            component?.didStartEditing = { [weak self] input in
                guard let self = self else { return }
                self.typedRow?.value = input.text
                self.typedRow?.didStartEditing?()
            }
            component?.didChangedText = { [weak self] input in
                guard let self = self else { return }
                self.typedRow?.value = input.text
                self.typedRow?.didChangedText?()
            }
            component?.didFinishEditing = { [weak self] input in
                guard let self = self else { return }
                self.typedRow?.value = input.text
                self.typedRow?.didFinishEditing?()
            }
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
    }
}
