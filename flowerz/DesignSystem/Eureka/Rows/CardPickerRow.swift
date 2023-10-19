//
//  CardPickerRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 20.08.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.CardPicker {
    
    /// Компонент выбора единичной карточки из списка. Компонент Eureka.
    /// Отображает любое количество карточек с горизонтальной прокруткой.
    /// При выборе карточки отображает детальную информацию и предоставляет возможность отмены выбора.
    final class CardPickerRow: Row<CardPickerCell>, RowType {
        
        /// Тег карточки
        public typealias Tag = String
        
        /// Модель компонента.
        /// При изменении модели компонент обновляется
        public var model: Components.CardPicker.Model {
            didSet { updateCell() }
        }
        
        /// Вызывается при нажатии на карточку. Возвращает тег карточки, на которую нажали
        public var didTapOnCardWithTag: ((Tag) -> Void)? {
            didSet { updateCell() }
        }
        
        /// Вызывается при отмене выбора ранее выбранной карточки (при нажатии на кнопку "отмена")
        public var didUnselectedCard: (() -> Void)? {
            didSet { updateCell() }
        }
        
        /// Компонент выбора единичной карточки из списка. Компонент Eureka.
        /// Отображает любое количество карточек с горизонтальной прокруткой.
        /// При выборе карточки отображает детальную информацию и предоставляет возможность отмены выбора.
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - model: модель компонента
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.CardPicker.Model,
            _ initializer: ((CardPickerRow) -> Void)? = nil
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

public extension EurekaComponents.CardPicker {
    
    /// Компонент выбора единичной карточки из списка. Ячейка Eureka.
    /// Отображает любое количество карточек с горизонтальной прокруткой.
    /// При выборе карточки отображает детальную информацию и предоставляет возможность отмены выбора.
    final class CardPickerCell: CustomCell<String, Components.CardPicker>, CellType {
        
        /// Компонент Eureka
        private var typedRow: CardPickerRow? { row as? CardPickerRow }

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
            component?.didChangedHeight = { [weak self] in
                self?.invalidateIntrinsicContentSize()
            }
            component?.didTapOnCardWithTag = { [weak self] tag in
                self?.typedRow?.didTapOnCardWithTag?(tag)
            }
            component?.didUnselectedCard = { [weak self] in
                self?.typedRow?.didUnselectedCard?()
            }
            
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
