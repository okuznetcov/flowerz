//
//  PromoBannerRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.PromoBanner {
    
    /// Промо-баннер с фоновым изображением и кнопкой. Компонент Eureka.
    /// Содержит заголовок, подзаголовок, опциональную кнопку
    final class PromoBannerRow: Row<PromoBannerCell>, RowType {
        
        /// Модель промо-баннера.
        /// При изменении модели компонент обновляется
        public var model: Components.PromoBanner.Model {
            didSet { updateCell() }
        }
        
        /// Промо-баннер с фоновым изображением и кнопкой. Компонент Eureka.
        /// Содержит заголовок, подзаголовок, опциональную кнопку
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - model: модель промо-баннера
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.PromoBanner.Model,
            _ initializer: ((PromoBannerRow) -> Void)? = nil
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

public extension EurekaComponents.PromoBanner {
    
    /// Промо-баннер с фоновым изображением и кнопкой. Компонент Eureka.
    /// Содержит заголовок, подзаголовок, опциональную кнопку
    final class PromoBannerCell: CustomCell<String, Components.PromoBanner>, CellType {
        
        /// Компонент Eureka
        private var typedRow: PromoBannerRow? { row as? PromoBannerRow }
        
        /// Вызывается при нажатии на кнопку внутри промо-баннера
        var didTapOnButton: (() -> Void)? {
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
            component?.didTapOnButton = didTapOnButton
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
