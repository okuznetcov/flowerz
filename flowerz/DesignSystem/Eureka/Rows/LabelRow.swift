//
//  LabelRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.08.2023.
//

import Eureka

public extension EurekaComponents.Label {
    
    /// Лейбл без заголовка (простой текст). Компонент Eureka.
    /// Поддерживает подсветку части текста как ссылку.
    /// На нажатие реагирует весь компонент целиком.
    /// Поддержка предопределенных стилей.
    final class LabelRow: Row<LabelCell>, RowType {
        
        /// Модель лейбла.
        /// При изменении модели компонент обновляется
        public var model: Components.Label.Model {
            didSet { updateCell() }
        }
        
        /// Лейбл без заголовка (простой текст). Компонент Eureka.
        /// Поддерживает подсветку части текста как ссылку.
        /// На нажатие реагирует весь компонент целиком.
        /// Поддержка предопределенных стилей.
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - model: модель лейбла
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.Label.Model,
            _ initializer: ((LabelRow) -> Void)? = nil
        ) {
            self.model = model
            super.init(tag: tag)
            initializer?(self)
        }
        
        required init(tag: String?) {
            fatalError("init(tag:) has not been implemented")
        }
    }
}

public extension EurekaComponents.Label {
    
    /// Лейбл без заголовка (простой текст). Ячейка Eureka.
    /// Поддерживает подсветку части текста как ссылку.
    /// На нажатие реагирует весь компонент целиком.
    /// Поддержка предопределенных стилей.
    final class LabelCell: CustomCell<String, Components.Label>, CellType {
        
        /// Компонент Eureka
        private var typedRow: LabelRow? { row as? LabelRow }
        
        /// Вызывается при нажатии на лейбл
        var didTapOnLabel: (() -> Void)? {
            didSet { update() }
        }
        
        /// Настраивает ячейку
        public override func setup() {
            guard let typedRow = typedRow else { return }
            component = Components.Label(with: typedRow.model)
            super.setup()
        }
        
        /// Обновляет ячейку
        public override func update() {
            super.update()
            guard let typedRow = typedRow else { return }
            component?.model = typedRow.model
            component?.didTapOnText = didTapOnLabel
            
            invalidateIntrinsicContentSize()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
    }
}
