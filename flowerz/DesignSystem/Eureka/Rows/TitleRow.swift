//
//  TitleRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.Title {
    
    /// Заголовок + подзаголовок. Компонент Eureka.
    final class TitleRow: Row<TitleCell>, RowType {
        
        /// Модель компонента.
        /// При изменении модели компонент обновляется
        public var model: Components.Title.Model {
            didSet { updateCell() }
        }
        
        /// Заголовок + подзаголовок. Компонент Eureka.
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - model: модель компонента
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.Title.Model,
            _ initializer: ((TitleRow) -> Void)? = nil
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

public extension EurekaComponents.Title {
    
    /// Заголовок + подзаголовок. Ячейка Eureka.
    final class TitleCell: CustomCell<String, Components.Title>, CellType {
        
        /// Компонент Eureka
        private var typedRow: TitleRow? { row as? TitleRow }

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
