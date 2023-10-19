//
//  Button.swift
//  flowerz
//
//  Created by Кузнецов Олег on 27.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + Button
// ✅ UniversalTableView — ButtonItem
// ✅ Eureka — ButtonRow

extension Components {
    
    /// Кнопка в разных стилях и размерах
    public final class Button: BaseButton {
        
        // MARK: - Nested Types
        
        /// Константы
        private enum Consts {
            /// Скругление углов кнопки для стиля rounded
            static let cornerRadiusForRoundedButton: CGFloat = 10
        }
        
        // MARK: - Public properties
        
        /// Модель кнопки
        /// При изменении модели компонент обновляется
        public lazy var model: Model = {
            fatalError("Нет модели кнопки")
        }() {
            didSet { setup() }
        }
        
        // MARK: - Private properties
        
        /// Лейбл с текстом в кнопке (отображает текст)
        private let label: UILabel = {
            let label = UILabel()
            label.isUserInteractionEnabled = false
            label.numberOfLines = 1
            label.textAlignment = .center
            
            return label
        }()
        
        // MARK: - Init
        
        /// Кнопка в разных стилях и размерах
        public init(model: Model) {
            super.init(frame: .zero)
            addSubview(label)
            self.model = model
        }
        
        public required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        // MARK: - Override
        
        /// Обновляет текст в кнопке. Предпочтительный подход — передвать текст кнопки в модель при инициализации
        /// - Parameters:
        ///   - title: текст кнопки
        ///   - state: UIControl.State, для которого необходимо обновить текст кнопки (обновит для всех)
        public override func setTitle(_ title: String?, for state: UIControl.State) {
            label.text = title
        }
        
        // swiftlint:disable line_length
        @available(*, deprecated, message: "Не используйте backgroundColor для присвоения цвета кнопки. Вместо этого используйте Color.")
        public override var backgroundColor: UIColor? {
            didSet { }
        }
        
        // MARK: - Private methods
        
        /// Настраивает кнопку
        private func setup() {
            
            // Убираем все констрейнты
            snp.removeConstraints()
            label.snp.removeConstraints()
            
            // Извлекаем параметры кнопки
            let parameters = model.size.parameters()
            
            // Сеттим текст в лейбле
            label.attributedText = .styled(model.text, with: parameters.typography)
            
            // Скругляем углы
            switch model.style {
                case .circular:
                    makeRoundCorners(radius: parameters.height / 2)
                
                case .rounded:
                    layer.cornerRadius = Consts.cornerRadiusForRoundedButton
            }
            
            //let borderColor = Color.dynamicColor(light: model.color.darker(by: 0.2), dark: model.color.lighter(by: 0.2))
            //layer.borderColor = borderColor.cgColor
            //layer.borderWidth = 3
            
            // Сеттим цвет кнопки
            color = model.color
            
            // Сеттим цвет текста кнопки
            label.textColor = model.textColor
            
            // Настраиваем расположение лейбла
            label.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview().inset(parameters.height / 2)
            }
            
            // Настраиваем высоту кнопки
            snp.makeConstraints { make in
                make.height.equalTo(model.size.parameters().height).priority(.required)
            }
            
            // Сеттим тактильный отклик, если это необходимо
            if model.performsHapticFeedback {
                hapticFeedback = parameters.hapticFeedback
            }
            
            layoutIfNeeded()
        }
    }
}
