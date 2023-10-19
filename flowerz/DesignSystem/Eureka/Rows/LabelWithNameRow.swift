//
//  LabelWithNameRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 30.07.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.LabelWithName {
    
    /// Лейбл с названием (заголовком). Компонент Eureka
    final class LabelWithNameRow: Row<LabelWithNameCell>, RowType {
        
        /// Модель лейбла.
        /// При изменении модели компонент обновляется
        public var model: Components.LabelWithName.Model {
            didSet { updateCell() }
        }
        
        /// Лейбл с названием (заголовком). Компонент Eureka
        /// - Parameters:
        ///   - tag: уникальный тег элемента
        ///   - model: модель лейбла
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.LabelWithName.Model,
            _ initializer: ((LabelWithNameRow) -> Void)? = nil
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

public extension EurekaComponents.LabelWithName {
    
    /// Лейбл с названием (заголовком). Ячейка Eureka
    final class LabelWithNameCell: CustomCell<String, Components.LabelWithName>, CellType {
        
        /// Компонент Eureka
        private var typedRow: LabelWithNameRow? { row as? LabelWithNameRow }
        
        /// Настраивает ячейку
        public override func setup() {
            guard let typedRow = typedRow else { return }
            component = Components.LabelWithName(with: typedRow.model)
            super.setup()
        }
        
        /// Обновляет ячейку
        public override func update() {
            super.update()
            guard let typedRow = typedRow else { return }
            component?.model = typedRow.model
            
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
