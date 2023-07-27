//
//  Button.swift
//  flowerz
//
//  Created by Кузнецов Олег on 27.07.2023.
//

import UIKit

/// Кнопка в разных стилях и размерах
public final class Button: BaseButton {
    
    // MARK: - Nested Types
    
    /// Модель кнопки
    public struct Model {
        /// Текст в кнопке
        let text: String
        /// Цвет текста кнопки
        let textColor: UIColor
        /// Цвет фона кнопки
        let color: UIColor
        /// Размер кнопки
        let size: Size
        /// Стиль кнопки
        let style: Style
    }
    
    /// Параметры размера кнопки
    struct SizeParameters {
        /// Типографика
        let typography: Typography
        /// Высота кнопки
        let height: CGFloat
    }
    
    /// Размер кнопки
    public enum Size {
        /// Small Button h35 Paragraph 12 Medium 0.0
        case small
        /// Medium Button h40 Header 15 Semibold -0.5
        case medium
        /// Large Button h50 Header 20 Bold -0.5
        case large
        
        /// Возвращает параметры кнопки исходя из выбранного размера
        /// - Returns: параметры кнопки
        func parameters() -> SizeParameters {
            switch self {
                case .small:
                    return .init(typography: .p2Medium, height: 35)
                
                case .medium:
                    return .init(typography: .h3Semibold, height: 40)
                
                case .large:
                    return .init(typography: .h2Bold, height: 50)
            }
        }
    }
    
    /// Стиль кнопки
    public enum Style {
        /// Скругленные углы
        case rounded
        /// Полностью круглые углы
        case circular
    }
    
    // MARK: - Public properties
    
    /// Параметры отображения кнопки
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
                layer.cornerRadius = 10
        }
        
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
        
        layoutIfNeeded()
    }
}
