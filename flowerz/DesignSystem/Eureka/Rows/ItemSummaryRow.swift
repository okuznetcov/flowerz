//
//  ItemSummaryRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.ItemSummary {
    
    /// Сводка по объекту. Компонент Eureka.
    /// Слева: Карточка с картинкой, заголовком, подзаголовком и опциональной тенью
    /// Справа: группа лейблов с заголовками
    final class ItemSummaryRow: Row<ItemSummaryCell>, RowType {
        
        /// Модель компонента сводка по объекту
        /// При изменении модели компонент обновляется
        public var model: Components.ItemSummary.Model {
            didSet { updateCell() }
        }
        
        public var didTapOnButton: (() -> Void)? {
            didSet { updateCell() }
        }
        
        /// Сводка по объекту. Компонент Eureka.
        /// Слева: Карточка с картинкой, заголовком, подзаголовком и опциональной тенью
        /// Справа: группа лейблов с заголовками
        /// - Parameters:
        ///   - tag: уникальный тег элемента
        ///   - model: модель компонента
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.ItemSummary.Model,
            _ initializer: ((ItemSummaryRow) -> Void)? = nil
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

public extension EurekaComponents.ItemSummary {
    
    /// Сводка по объекту. Ячейка Eureka.
    /// Слева: Карточка с картинкой, заголовком, подзаголовком и опциональной тенью
    /// Справа: группа лейблов с заголовками
    final class ItemSummaryCell: CustomCell<String, Components.ItemSummary>, CellType {
        
        /// Компонент Eureka
        private var typedRow: ItemSummaryRow? { row as? ItemSummaryRow }
        
        /// Настраивает ячейку
        public override func setup() {
            guard let typedRow = typedRow else { return }
            component = .init(with: typedRow.model)
            super.setup()
        }
        
        /// Обновляет ячейку
        public override func update() {
            super.update()
            guard let typedRow = typedRow else { return }
            component?.model = typedRow.model
            component?.didTapOnButton = typedRow.didTapOnButton
            
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
