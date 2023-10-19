//
//  Label.swift
//  flowerz
//
//  Created by Кузнецов Олег on 30.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + Label
// ❌ UniversalTableView
// ✅ Eureka — LabelRow

extension Components {
    
    /// Лейбл без заголовка (простой текст).
    /// Поддерживает подсветку части текста как ссылку.
    /// На нажатие реагирует весь компонент целиком.
    /// Поддержка предопределенных стилей.
    public final class Label: UIView {
        
        // MARK: - Nested Types

        /// Константы
        private enum Consts {
            
            /// Размеры
            enum Sizes {
                /// Горизонтальные отсупы
                static let horizontalOffset: CGFloat = 16
                /// Вертикальные отступы
                static let verticalOffset: CGFloat = 8
            }
            
            /// Цвет текста, который будет отображаться как ссылка
            static let linkColor: UIColor = .link
        }
        
        // MARK: - Public properies
        
        /// Вызывается при нажатии на текст
        public var didTapOnText: (() -> Void)?
        
        /// Модель лейбла.
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                setup(using: model)
            }
        }
        
        // MARK: - Private properies
        
        /// Основной текст
        private let textLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.isUserInteractionEnabled = true
            return label
        }()
        
        // MARK: - Init
        
        /// Лейбл без заголовка (простой текст).
        /// Поддерживает подсветку части текста как ссылку.
        /// На нажатие реагирует весь компонент целиком.
        /// Поддержка предопределенных стилей.
        /// - Parameter model: модель лейбла
        public init(with model: Model) {
            super.init(frame: .zero)
            addSubviews()
            setup(using: model)
            makeConstraints()
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        // MARK: - Private methods
        
        /// Добавляет сабвью
        private func addSubviews() {
            addSubview(textLabel)
        }
        
        /// Обновляет компонент согласно модели
        /// - Parameter model: модель лейбла
        private func setup(using model: Model) {
            
            // Получаем конфиг из модели
            let config = model.asConfig()
            
            // Настраиваем основной цвет и шрифт
            textLabel.textColor = config.style.asColor()
            textLabel.font = config.font
            textLabel.textAlignment = config.alignment
            
            // Если модель содержит текст ссылки и он не пуст
            if let linkText = config.linkText, !linkText.isEmpty {
                
                // Подсвечиваем часть текста как ссылку
                typealias Attribute = NSAttributedString.Key
                let attributedString = NSMutableAttributedString(string: config.text)
                
                let linkRange = NSString(string: config.text).range(of: linkText)
                attributedString.addAttribute(Attribute.foregroundColor, value: Consts.linkColor, range: linkRange)
                
                textLabel.attributedText = attributedString
            } else {
                
                // Иначе просто сеттим текст
                textLabel.text = config.text
            }
        }
        
        /// Настраивает констрейнты
        private func makeConstraints() {

            // Настраиваем констрейнты
            textLabel.snp.makeConstraints {
                $0.top.equalToSuperview().inset(Consts.Sizes.verticalOffset)
                $0.leading.trailing.equalToSuperview().inset(Consts.Sizes.horizontalOffset)
                $0.bottom.lessThanOrEqualToSuperview().inset(Consts.Sizes.verticalOffset)
            }
            
            // Привязываем экшен на нажатие по лейблу
            let tap = UITapGestureRecognizer(target: self, action: #selector(didTapOnLabel))
            textLabel.addGestureRecognizer(tap)
        }
        
        // MARK: - Actions
        
        /// Вызывается при нажатии на лейбл
        @objc private func didTapOnLabel() {
            didTapOnText?()
        }
    }
}
