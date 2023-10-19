//
//  SwitchRow.swift
//  flowerz
//
//  Created by Кузнецов Олег on 31.07.2023.
//

import Eureka
import UIKit
import SnapKit

public extension EurekaComponents.Switch {
    
    /// Переключатель с текстом. Компонент Eureka.
    /// Может быть два текста для включенного и выключенного состояний.
    /// Статус переключателя содержится в row.value. При изменении величин компонент обновляется.
    final class SwitchRow: Row<SwitchCell>, RowType {
        
        private enum Consts {
            /// Шрифт в названии переключателя
            static let font: Typography = .p1Regular
        }
        
        /// Модель переключателя
        public struct Model {
            let textEnabled: String
            let textDisabled: String?
        }
        
        /// Модель переключателя.
        /// При изменении модели компонент обновляется.
        public var model: Model {
            didSet { configureCell() }
        }
        
        /// Переключатель с текстом. Компонент Eureka.
        /// Может быть два текста для включенного и выключенного состояний
        /// Статус переключателя содержится в row.value. При изменении величин компонент обновляется.
        /// - Parameters:
        ///   - tag: уникальный тег компонента
        ///   - model: модель переключателя
        ///   - value: флаг, включен ли переключатель (true — включен; false — выключен)
        ///   - initializer: настроенный row
        public init(
            _ tag: String?,
            model: Model,
            value: Bool,
            _ initializer: ((SwitchRow) -> Void)? = nil
        ) {
            self.model = model
            super.init(tag: tag)
            self.value = value
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            displayValueFor = nil
            cellStyle = .default
            configureCell()
            
            initializer?(self)
        }
        
        /// Настраивает ячейку
        func configureCell() {
            let textDisabled = model.textDisabled ?? model.textEnabled
            
            onChange { row in
                row.title = (row.value ?? false) ? self.model.textEnabled : textDisabled
                row.updateCell()
            }
            
            cellUpdate { cell, row in
                guard let text = row.title else { return }
                cell.textLabel?.attributedText = .styled(text, with: Consts.font)
            }
            
            value = value
            title = value ?? false ? self.model.textEnabled : textDisabled
            updateCell()
        }
        
        required init(tag: String?) {
            fatalError("init(tag:) has not been implemented")
        }
    }
}
