//
//  ItemSummary.swift
//  flowerz
//
//  Created by Кузнецов Олег on 30.07.2023.
//

import UIKit
import SnapKit

// MARK: - Components + ItemSummary

extension Components {
    
    /// Компонент сводка по объекту
    /// Слева: Карточка с картинкой, заголовком, подзаголовком и опциональной тенью
    /// Справа: группа лейблов с заголовками
    public final class ItemSummary: UIView {

        // MARK: - Nested Types
        
        /// Размеры
        private enum Sizes {
            /// Вертикальное расстояние между полями в вертикальном стеке
            static let verticalSpaceBetweenFields: CGFloat = 2
            /// Вертикальный отсуп
            static let verticalOffset: CGFloat = 8
            /// Горизонтальный отступ
            static let horizontalOffset: CGFloat = 16
            /// Соотношение сторон карточки с картинкой
            static let cardAspectRatio = 1.2
        }
        
        private enum CardPlacement {
            case center
            case left
        }
        
        // MARK: - Public properties
        
        /// Модель компонента сводка по объекту
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                setup(using: model)
                makeConstraints(with: model)
            }
        }

        // MARK: - Private properties
        
        private var cardPlacement: CardPlacement {
            guard let model = model else { return .left }
            if model.button == nil && model.fields.isEmpty { return .center }
            return .left
        }
        
        /// Вертикальный контейнер, в котором размещаются лейблы с заголовками
        private let contentContainer: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = Sizes.verticalSpaceBetweenFields
            stack.isUserInteractionEnabled = false
            stack.distribution = .fillProportionally
            
            return stack
        }()
        
        private var button = Button(model: .init(text: "Кнопка", textColor: .black, color: .clear, size: .small, style: .circular, performsHapticFeedback: false))
        
        public var didTapOnButton: (() -> Void)?
        
        /// Карточка с картинкой
        private let card: ImageWithNameCard = ImageWithNameCard()

        // MARK: - Init
        
        /// Компонент сводка по объекту
        /// Слева: Карточка с картинкой, заголовком, подзаголовком и опциональной тенью
        /// Справа: группа лейблов с заголовками
        /// - Parameter model: модель данных, на основе которой будет отрисован компонент
        public init(with model: Model) {
            super.init(frame: .zero)
            setup(using: model)
            makeConstraints(with: model)
            button.touchUpAction = { [weak self] in self?.didTapOnButton?() }
        }
        
        @available(*, unavailable)
        required init?(coder aDecoder: NSCoder) { return nil }
        
        // MARK: - Private methods
        
        /// Настраивает компонент
        /// - Parameter model: модель
        private func setup(using model: Model) {
            
            // Убираем карточку и все лейблы
            card.removeFromSuperview()
            contentContainer.subviews.forEach { field in
                field.removeFromSuperview()
            }
            button.removeFromSuperview()
            
            // Добавляем карточку слева и настраиваем ее
            addSubview(card)
            card.configure(with: model.card)
            card.isSelected = model.isSelected
            
            if let buttonModel = model.button {
                button.model = buttonModel
                addSubview(button)
            }
            
            guard !model.fields.isEmpty else { return }
            
            // Добавляем контейнер для полей
            addSubview(contentContainer)
            
            // Добавляем лейблы справа
            model.fields.forEach { fieldModel in
                let label = LabelWithName(with: fieldModel)
                contentContainer.addArrangedSubview(label)
            }
            
            contentContainer.subviews.last?.setContentHuggingPriority(.defaultLow, for: .vertical)
        }
        
        /// Настраивает констрейнты
        private func makeConstraints(with model: Model) {
            
            // Убираем все констрейнты
            card.snp.removeConstraints()
            contentContainer.snp.removeConstraints()
            button.snp.removeConstraints()
            
            // Констрейнты карточки с картинкой (слева)
            card.snp.makeConstraints { make in
                
                switch cardPlacement {
                    case .center:
                        make.centerX.equalToSuperview()
                    case .left:
                        make.leading.equalToSuperview().offset(Sizes.horizontalOffset)
                }
                make.top.equalToSuperview().offset(Sizes.verticalOffset)
                
                // Настраиваем ширину карточки в зависимости от стиля в модели
                switch model.cardSize {
                    
                    /// Большая. Карточка с картинкой занимает половину экрана по ширине
                    case .large:
                        make.width.equalTo(snp.width).dividedBy(2)
                    
                    /// Средняя. Карточка с картинкой занимает треть экрана по ширине
                    case .medium:
                        make.width.equalTo(snp.width).dividedBy(3)
                    
                    case .exact:
                        make.width.equalTo(Components.ImageWithNameCard.CollectionViewSize.width)
                }
                
                make.bottom.lessThanOrEqualToSuperview().inset(Sizes.verticalOffset)
            }
            
            if !model.fields.isEmpty {
                
                // Констрейнты контейнера с лейблами (справа)
                contentContainer.snp.makeConstraints { make in
                    make.top.equalToSuperview().offset(Sizes.verticalOffset)
                    make.trailing.equalToSuperview().inset(Sizes.horizontalOffset)
                    make.leading.equalTo(card.snp.trailing)
                    if model.button != nil {
                        make.bottom.lessThanOrEqualTo(button.snp.top).inset(-Sizes.verticalOffset)
                    } else {
                        make.bottom.lessThanOrEqualToSuperview().inset(Sizes.verticalOffset)
                    }
                }
            }
            
            if model.button != nil {
                button.snp.makeConstraints { make in
                    make.leading.equalTo(card.snp.trailing).offset(Sizes.horizontalOffset)
                    make.trailing.lessThanOrEqualToSuperview().offset(Sizes.horizontalOffset)
                    make.bottom.equalToSuperview().inset(Sizes.verticalOffset)
                }
            }
        }
    }
}
