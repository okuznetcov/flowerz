//
//  HistoryRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.History {
    
    /// Карточка истории ухода. Компонент Eureka.
    final class HistoryRow: Row<HistoryCell>, RowType {
        
        /// Модель карточки истории ухода.
        /// При изменении модели компонент обновляется
        public var model: Components.History.Model {
            didSet { updateCell() }
        }
        
        /// Карточка истории ухода. Компонент Eureka.
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - model: модель карточки истории ухода.
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.History.Model,
            _ initializer: ((HistoryRow) -> Void)? = nil
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

public extension EurekaComponents.History {
    
    /// Карточка истории ухода. Ячейка Eureka.
    final class HistoryCell: CustomCell<String, Components.History>, CellType {
        
        /// Компонент Eureka
        private var typedRow: HistoryRow? { row as? HistoryRow }
        
        /// Вызывается при нажатии на карточку
        var didTapOnCard: (() -> Void)? {
            didSet { update() }
        }
        
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
            component?.didTapOnCard = didTapOnCard
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
