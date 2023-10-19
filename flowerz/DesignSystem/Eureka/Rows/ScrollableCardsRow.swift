//
//  ScrollableCardsRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.ScrollableCards {
    
    /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой. Компонент Eureka.
    final class ScrollableCardsRow: Row<ScrollableCardsCell>, RowType {
        
        /// Модель компонента
        /// При изменении модели компонент обновляется
        public var model: Components.ScrollableCards.Model {
            didSet { updateCell() }
        }
        
        /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой. Компонент Eureka.
        /// - Parameters:
        ///   - tag: уникальный тег элемента
        ///   - model: модель компонента
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Components.ScrollableCards.Model,
            _ initializer: ((ScrollableCardsRow) -> Void)? = nil
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

public extension EurekaComponents.ScrollableCards {
    
    /// Группа карточек с картинкой, заголовком и подзаголовком внутри контейнера с горизональной прокруткой. Ячейка Eureka.
    final class ScrollableCardsCell: CustomCell<String, Components.ScrollableCards>, CellType {
        
        /// Компонент Eureka
        private var typedRow: ScrollableCardsRow? { row as? ScrollableCardsRow }
        
        /// Вызывается при нажатии на карточку
        public var didTapOnCardWithTag: ((String) -> Void)? {
            didSet { update() }
        }
        
        public var didChangedSelection: (([String: Bool]) -> Void)? {
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
            guard let typedRow = typedRow, let component = component else { return }
            component.didTapOnCardWithTag = didTapOnCardWithTag
            component.didChangedSelection = didChangedSelection
            component.model = typedRow.model
            component.snp.makeConstraints { make in
                make.height.equalTo(Components.ScrollableCards.Size.height)
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
