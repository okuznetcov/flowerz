//
//  BannerRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.Banner {
    
    /// Баннер в различных стилях. Компонент Eureka.
    /// Может содержать заголовок, подзаголовок и изображение.
    final class BannerRow: Row<BannerCell>, RowType {
        
        /// Модель баннера.
        /// При изменении модели компонент обновляется
        public var model: Components.Banner.Model {
            didSet { updateCell() }
        }
        
        /// Баннер в различных стилях. Компонент Eureka.
        /// Может содержать заголовок, подзаголовок и изображение.
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - model: модель баннера
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.Banner.Model,
            _ initializer: ((BannerRow) -> Void)? = nil
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

public extension EurekaComponents.Banner {
    
    /// Баннер в различных стилях. Ячейка Eureka.
    /// Может содержать заголовок, подзаголовок и изображение.
    final class BannerCell: CustomCell<String, Components.Banner>, CellType {
        
        /// Компонент Eureka
        private var typedRow: BannerRow? { row as? BannerRow }
        
        /// Вызывается при нажатии на баннер
        var didTapOnBanner: (() -> Void)? {
            didSet { update() }
        }
        
        /// Настраивает ячейку
        public override func setup() {
            guard let typedRow = typedRow else { return }
            component = Components.Banner(with: typedRow.model)
            super.setup()
        }
        
        /// Обновляет ячейку
        public override func update() {
            super.update()
            guard let typedRow = typedRow else { return }
            component?.didTapOnBanner = didTapOnBanner
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
