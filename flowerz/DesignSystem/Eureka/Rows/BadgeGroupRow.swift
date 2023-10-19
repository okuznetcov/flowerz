//
//  BadgeGroupRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 01.08.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.BadgeGroup {
    
    /// Группа бейджей. Компонент Eureka.
    /// Отображает любое количество бейджей с различными цветами и текстом
    final class BadgeGroupRow: Row<BadgeGroupCell>, RowType {
        
        /// Массив моделей бейджей
        /// При изменении модели компонент обновляется
        public var badges: [Components.BadgeGroup.Badge] {
            didSet { updateCell() }
        }
        
        /// Группа бейджей. Компонент Eureka.
        /// Отображает любое количество бейджей с различными цветами и текстом
        /// - Parameters:
        ///   - tag: уникальный тег элемента
        ///   - badges: массив моделей бейджей
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            badges: [Components.BadgeGroup.Badge],
            _ initializer: ((BadgeGroupRow) -> Void)? = nil
        ) {
            self.badges = badges
            super.init(tag: tag)
            initializer?(self)
        }
        
        required init(tag: String?) {
            fatalError("init(tag:) has not been implemented")
        }
    }
}

public extension EurekaComponents.BadgeGroup {
    
    /// Группа бейджей. Ячейка Eureka.
    /// Отображает любое количество бейджей с различными цветами и текстом
    final class BadgeGroupCell: Cell<String>, CellType {
        
        /// Компонент Eureka
        private var typedRow: BadgeGroupRow? { row as? BadgeGroupRow }
        
        /// Компонент дизайн-системы
        private var component: Components.BadgeGroup?
        
        /// Настраивает ячейку
        public override func setup() {
            guard let typedRow = typedRow else { return }
            component = .init()
            component?.badges = typedRow.badges
            super.setup()
        }
        
        /// Обновляет ячейку
        public override func update() {
            super.update()
            
            /// Извлекаем typedRow и настраиваем компонент
            guard let typedRow = typedRow else { return }
            component?.badges = typedRow.badges
            
            /// Настраиваем констрейнты
            guard let component = component else { return }
            addSubview(component)
            component.snp.makeConstraints { make in
                make.top.bottom.equalToSuperview().inset(8)
                make.leading.trailing.equalToSuperview().inset(16)
            }
            
            /// Отключаем подстветку ячейки при нажатии и делаем фон ячейки прозрачным
            selectionStyle = .none
            backgroundColor = .clear
            
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
