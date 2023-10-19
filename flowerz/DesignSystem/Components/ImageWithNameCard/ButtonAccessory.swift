//
//  ButtonAccessory.swift
//  flowerz
//
//  Created by Кузнецов Олег on 15.08.2023.
//

import UIKit

extension Components.ImageWithNameCard {
    
    public final class ButtonAccessory: UIView {
        
        // MARK: - Nested Types

        public struct Model {
            let title: String
        }
        
        public var didTapOnButton: (() -> Void)?
        
        // MARK: - Public properties
        
        /// Модель данных, на основе которой будет отрисован компонент
        /// При изменении модели компонент обновляется
        public var model: Model? {
            didSet {
                guard let model = model else { return }
                setup(using: model)
            }
        }

        /// Подзаголовок карточки
        private let button = Components.Button(
            model: .init(text: "Изменить", textColor: .darkGray, color: Color.backgroundSecondary.darker(by: 0.2), size: .small, style: .circular, performsHapticFeedback: false)
        )
        
        // MARK: - Init

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError()
        }
        
        /// - Parameter frame: область
        public override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        // MARK: - Public methods
    
        /// - Parameter model: модель данных, на основе которой будет отрисована карточка
        public func configure(with model: Model) {
            setup(using: model)
            addSubviews()
            makeConstraints()
        }
        
        // MARK: - Private methods

        /// - Parameter model: модель карточки
        private func setup(using model: Model) {
            button.pressUpAction = didTapOnButton
        }
        
        /// Добавляет сабвью
        private func addSubviews() {
            addSubview(button)
        }

        /// Настраивает констрейнты
        private func makeConstraints() {
            
            // Тексты
            button.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.trailing.equalToSuperview()
                make.height.lessThanOrEqualToSuperview()
            }
        }
    }
}
