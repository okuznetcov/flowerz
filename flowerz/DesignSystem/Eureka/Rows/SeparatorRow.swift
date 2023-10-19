//
//  SeparatorRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 14.08.2023.
//

import Eureka

public extension EurekaComponents.Separator {
    
    /// Серая линия-разделитель. Компонент Eureka.
    final class SeparatorRow: Row<SeparatorCell>, RowType {
        
        public private(set) var width: Components.Separator.Width
        
        /// Серая линия-разделитель. Компонент Eureka. Поддерживает разную ширину линии.
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - style: ширина разделителя
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            width: Components.Separator.Width
        ) {
            self.width = width
            super.init(tag: tag)
        }
        
        required init(tag: String?) {
            fatalError("init(tag:) has not been implemented")
        }
    }
}

public extension EurekaComponents.Separator {

    /// Серая линия-разделитель. Ячейка Eureka. Поддерживает разную ширину линии.
    final class SeparatorCell: CustomCell<String, Components.Separator>, CellType {
        
        /// Компонент Eureka
        private var typedRow: SeparatorRow? { row as? SeparatorRow }
        
        /// Настраивает ячейку
        public override func setup() {
            guard let typedRow = typedRow else { return }
            component = Components.Separator(width: typedRow.width)
            super.setup()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
    }
}
