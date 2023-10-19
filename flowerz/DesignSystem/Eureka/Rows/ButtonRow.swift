//
//  ButtonRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.Button {
    
    /// Кнопка в разных стилях и размерах. Компонент Eureka
    final class ButtonRow: Row<ButtonCell>, RowType {
        
        /// Модель кнопки
        /// При изменении модели компонент обновляется
        public var model: Components.Button.Model {
            didSet { updateCell() }
        }
        
        /// Кнопка в разных стилях и размерах. Компонент Eureka
        /// - Parameters:
        ///   - tag: уникальный тег элемента
        ///   - model: модель кнопки
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.Button.Model,
            _ initializer: ((ButtonRow) -> Void)? = nil
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

public extension EurekaComponents.Button {
    
    /// Кнопка в разных стилях и размерах. Ячейка Eureka
    final class ButtonCell: Cell<String>, CellType {
        
        /// Компонент Eureka
        private var typedRow: ButtonRow? { row as? ButtonRow }
        
        /// Компонент дизайн-системы
        private var component: Components.Button?
        
        /// Вызывается при нажатии на кнопку
        var didTapOnButton: (() -> Void)? {
            didSet { update() }
        }
        
        /// Настраивает ячейку
        public override func setup() {
            guard let typedRow = typedRow else { return }
            component = .init(model: typedRow.model)
            super.setup()
        }
        
        /// Обновляет ячейку
        public override func update() {
            super.update()
            
            /// Извлекаем typedRow и настраиваем кнопку
            guard let typedRow = typedRow else { return }
            component?.touchUpAction = didTapOnButton
            component?.model = typedRow.model
            
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
